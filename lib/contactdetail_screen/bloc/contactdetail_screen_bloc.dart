import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_chatapp/contactdetail_screen/bloc/contactdetail_screen_event.dart';
import 'package:test_chatapp/contactdetail_screen/bloc/contactdetail_screen_state.dart';

class ContactdetailScreenBloc
    extends Bloc<ContactdetailScreenEvent, ContactdetailScreenState> {
  ContactdetailScreenBloc() : super(ContactdetailScreenInitial()) {
    on<UserLogoutEvent>(_userlogout);
    on<UserDetailsEvent>(getuserdetails);
  }

  Future<void> _userlogout(
    ContactdetailScreenEvent event,
    Emitter<ContactdetailScreenState> emit,
  ) async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      log(e.toString());
      emit(LogoutError());
    }
  }

  FutureOr<void> getuserdetails(
    UserDetailsEvent event,
    Emitter<ContactdetailScreenState> emit,
  ) {
    try {
      var user = getstreamuserdetails();
      emit(GetuserDetail(user: user));
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<List<Map<String, dynamic>>> getstreamuserdetails() {
    return FirebaseFirestore.instance.collection('Userdetails').snapshots().map(
      (event) {
        return event.docs.map((e) {
          return e.data();
        }).toList();
      },
    );
  }
  
}
