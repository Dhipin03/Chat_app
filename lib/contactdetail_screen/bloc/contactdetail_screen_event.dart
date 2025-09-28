import 'package:equatable/equatable.dart';

abstract class ContactdetailScreenEvent extends Equatable {
  const ContactdetailScreenEvent();

  @override
  List<Object> get props => [];
}

class UserLogoutEvent extends ContactdetailScreenEvent {}

class UserDetailsEvent extends ContactdetailScreenEvent {}

class GetUnseenmsgcountEvent extends ContactdetailScreenEvent {
  final String rid;

  const GetUnseenmsgcountEvent({required this.rid});

  @override
  List<Object> get props => [rid];
}

class markmsgasseen extends ContactdetailScreenEvent {
  final String rid;

  const markmsgasseen({required this.rid});

  @override
  List<Object> get props => [rid];
}
