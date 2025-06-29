part of 'login_screen_bloc.dart';

class LoginScreenState extends Equatable {
  const LoginScreenState();

  @override
  List<Object> get props => [];
}

class LoginScreenInitial extends LoginScreenState {}

//succes state
class LoginScreenSucces extends LoginScreenState {
  User? user;
  LoginScreenSucces({this.user});
}

//Error state
class LoginScreenError extends LoginScreenState {
  String? errormsg;
  LoginScreenError({this.errormsg});
}

//Loading state
class LoginScreenLoading extends LoginScreenState {}
