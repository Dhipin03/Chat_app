part of 'signup_screen_bloc.dart';

class SignupScreenEvent extends Equatable {
  const SignupScreenEvent();

  @override
  List<Object> get props => [];
}

class Signupevent extends SignupScreenEvent {
  String useremail;
  String userpassword;
  Signupevent({required this.useremail, required this.userpassword});
}
