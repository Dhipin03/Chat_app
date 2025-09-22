part of 'forgotpassword_screen_cubit.dart';

sealed class ForgotpasswordScreenState extends Equatable {
  const ForgotpasswordScreenState();

  @override
  List<Object> get props => [];
}

final class ForgotpasswordScreenInitial extends ForgotpasswordScreenState {}

final class ForgotpasswordScreenSuccess extends ForgotpasswordScreenState {}

final class ForgotpasswordScreenError extends ForgotpasswordScreenState {}
