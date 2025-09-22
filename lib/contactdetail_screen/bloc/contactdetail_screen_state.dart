import 'package:equatable/equatable.dart';

class ContactdetailScreenState extends Equatable {
  const ContactdetailScreenState();

  @override
  List<Object> get props => [];
}

final class ContactdetailScreenInitial extends ContactdetailScreenState {}

final class LogoutError extends ContactdetailScreenState {}

final class GetuserDetail extends ContactdetailScreenState {
  var user;
  GetuserDetail({required this.user});
}

class UserlogoutSuccess extends ContactdetailScreenState {}
