part of 'chatdetail_screen_bloc.dart';

sealed class ChatdetailScreenState extends Equatable {
  const ChatdetailScreenState();

  @override
  List<Object> get props => [];
}

final class ChatdetailScreenInitial extends ChatdetailScreenState {}

final class Chatgetmsg extends ChatdetailScreenState {
  var msg;
  Chatgetmsg({required this.msg});
}

final class ChatError extends ChatdetailScreenState {}
