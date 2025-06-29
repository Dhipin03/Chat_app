import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_chatapp/contactdetail_screen/bloc/contactdetail_screen_event.dart';
import 'package:test_chatapp/contactdetail_screen/bloc/contactdetail_screen_state.dart';

class ContactdetailScreenBloc
    extends Bloc<ContactdetailScreenEvent, ContactdetailScreenState> {
  ContactdetailScreenBloc() : super(ContactdetailScreenInitial()) {
    on<ContactdetailScreenEvent>(_userlogout);
  }

  Future<void> _userlogout(
    ContactdetailScreenEvent event,
    Emitter<ContactdetailScreenState> emit,
  ) async {
    await FirebaseAuth.instance.signOut();
  }
}
