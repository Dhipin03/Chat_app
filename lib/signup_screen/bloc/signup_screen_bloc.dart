import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

part 'signup_screen_event.dart';
part 'signup_screen_state.dart';

class SignupScreenBloc extends Bloc<SignupScreenEvent, SignupScreenState> {
  SignupScreenBloc() : super(SignupScreenInitial()) {
    on<Signupevent>(_usersignup);
  }

  Future<void> _usersignup(
    Signupevent event,
    Emitter<SignupScreenState> emit,
  ) async {
    String? msg;
    emit(SignupScreenLoading());
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: event.useremail,
            password: event.userpassword,
          );
      emit(SignupScreenSucees(userdetail: credential.user));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        msg = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        msg = 'The account already exists for that email.';
      }
      emit(SignupScreenError(errormsg: msg));
    } catch (e) {
      emit(SignupScreenError(errormsg: e.toString()));
    }
  }
}
