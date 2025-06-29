part of 'login_screen_bloc.dart';

class LoginScreenEvent extends Equatable {
  const LoginScreenEvent();

  @override
  List<Object> get props => [];
}

class UserloginEvent extends LoginScreenEvent {
  String useremail;
  String userpass;
  UserloginEvent({required this.useremail, required this.userpass});
}
