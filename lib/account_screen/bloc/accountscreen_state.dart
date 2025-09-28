part of 'accountscreen_bloc.dart';

sealed class AccountscreenState extends Equatable {
  const AccountscreenState();

  @override
  List<Object> get props => [];
}

final class AccountscreenInitial extends AccountscreenState {}

final class CurrentuserdetailsGet extends AccountscreenState {
  var userdetails;
  CurrentuserdetailsGet({required this.userdetails});
}

class UpdateduserdetailsState extends AccountscreenState {}
