import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  LoginScreenBloc() : super(LoginScreenInitial()) {
    on<UserloginEvent>(_userlogin);
  }

  Future<void> _userlogin(
    UserloginEvent event,
    Emitter<LoginScreenState> emit,
  ) async {
    String? errmsg;
    try {
      emit(LoginScreenLoading());
      //check user auth
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: event.useremail,
        password: event.userpass,
      );
      //Success
      emit(LoginScreenSucces(user: credential.user));
    } on FirebaseAuthException catch (e) {
      //error
      if (e.code == 'user-not-found') {
        errmsg = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errmsg = 'Wrong password provided for that user.';
      }
      emit(LoginScreenError(errormsg: errmsg));
    }
  }
}
