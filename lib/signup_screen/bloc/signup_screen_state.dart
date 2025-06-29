part of 'signup_screen_bloc.dart';

class SignupScreenState extends Equatable {
  const SignupScreenState();

  @override
  List<Object> get props => [];
}

class SignupScreenInitial extends SignupScreenState {}

class SignupScreenSucees extends SignupScreenState {
  var userdetail;
  SignupScreenSucees({this.userdetail});
}

class SignupScreenLoading extends SignupScreenState {}

class SignupScreenError extends SignupScreenState {
  String? errormsg;
  SignupScreenError({this.errormsg});
}
