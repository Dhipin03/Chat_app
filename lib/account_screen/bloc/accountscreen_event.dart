part of 'accountscreen_bloc.dart';

sealed class AccountscreenEvent extends Equatable {
  const AccountscreenEvent();

  @override
  List<Object> get props => [];
}

class CurrentUserDetailsEvent extends AccountscreenEvent {}

class UpdateUserDetailsEvent extends AccountscreenEvent {
  String name;
  String email;
  String pass;
  UpdateUserDetailsEvent({
    required this.name,
    required this.email,
    required this.pass,
  });
}
