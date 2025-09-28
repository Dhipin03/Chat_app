part of 'signup_screen_bloc.dart';

class SignupScreenEvent extends Equatable {
  const SignupScreenEvent();

  @override
  List<Object> get props => [];
}

class Signupevent extends SignupScreenEvent {
  String useremail;
  String userpassword;
  String username;
  Signupevent({
    required this.useremail,
    required this.userpassword,
    required this.username,
  });
}
