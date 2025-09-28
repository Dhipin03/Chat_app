import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'accountscreen_event.dart';
part 'accountscreen_state.dart';

class AccountscreenBloc extends Bloc<AccountscreenEvent, AccountscreenState> {
  AccountscreenBloc() : super(AccountscreenInitial()) {
    on<CurrentUserDetailsEvent>(_currentuserdetails);
    on<UpdateUserDetailsEvent>(_updateuserdetails);
  }

  FutureOr<void> _currentuserdetails(
    CurrentUserDetailsEvent event,
    Emitter<AccountscreenState> emit,
  ) async {
    try {
      var currentuser = await _streamcurrenruserdetails();
      emit(CurrentuserdetailsGet(userdetails: currentuser));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<Map<String, dynamic>?> _streamcurrenruserdetails() async {
    return await FirebaseFirestore.instance
        .collection('Userdetails')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            return documentSnapshot.data() as Map<String, dynamic>?;
          } else {
            return null;
          }
        });
  }

  FutureOr<void> _updateuserdetails(
    UpdateUserDetailsEvent event,
    Emitter<AccountscreenState> emit,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('Userdetails')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
            'name': event.name,
            'pass': event.pass,
            'email': event.email,
          });
      emit(UpdateduserdetailsState());
    } catch (e) {
      log(e.toString());
    }
  }
}
