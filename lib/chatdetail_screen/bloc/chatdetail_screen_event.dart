part of 'chatdetail_screen_bloc.dart';

sealed class ChatdetailScreenEvent extends Equatable {
  const ChatdetailScreenEvent();

  @override
  List<Object> get props => [];
}

class ChatdetailsndmsgEvent extends ChatdetailScreenEvent {
  String msg;
  var rid;
  ChatdetailsndmsgEvent({required this.msg, required this.rid});
}

class ChatdetailgetmsgEvent extends ChatdetailScreenEvent {
  var rid;
  ChatdetailgetmsgEvent({required this.rid});
}
