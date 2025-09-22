import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'forgotpassword_screen_state.dart';

class ForgotpasswordScreenCubit extends Cubit<ForgotpasswordScreenState> {
  ForgotpasswordScreenCubit() : super(ForgotpasswordScreenInitial());

  SendPasswordResetLink(String email) {
    try {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(ForgotpasswordScreenSuccess());
    } catch (e) {
      log(e.toString());
    }
  }
}
