import 'package:equatable/equatable.dart';

class ContactdetailScreenEvent extends Equatable {
  const ContactdetailScreenEvent();

  @override
  List<Object> get props => [];
}

class UserLogoutEvent extends ContactdetailScreenEvent {}

class UserLogoutErrorEvent extends ContactdetailScreenEvent {}

class UserDetailsEvent extends ContactdetailScreenEvent {}
