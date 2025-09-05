import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_chatapp/model/usermsg_model.dart';

part 'chatdetail_screen_event.dart';
part 'chatdetail_screen_state.dart';

class ChatdetailScreenBloc
    extends Bloc<ChatdetailScreenEvent, ChatdetailScreenState> {
  StreamSubscription<QuerySnapshot>? _messageSubscription;
  ChatdetailScreenBloc() : super(ChatdetailScreenInitial()) {
    on<ChatdetailsndmsgEvent>(sendusermsg);
    on<ChatdetailgetmsgEvent>(getusermsg);
    on<DeletemsgEvent>(deleteusermsg);
  }
  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    return super.close();
  }

  FutureOr<void> sendusermsg(
    ChatdetailsndmsgEvent event,
    Emitter<ChatdetailScreenState> emit,
  ) {
    var cuserid = FirebaseAuth.instance.currentUser!.uid;
    var cuseremail = FirebaseAuth.instance.currentUser!.email!;
    Timestamp timestamp = Timestamp.now();

    // Add to model
    Usermsg newusermsg = Usermsg(
      msg: event.msg,
      rid: event.rid,
      sid: cuserid,
      timestamp: timestamp,
      email: cuseremail,
    );

    //chat room id

    String chatroomid = createchatroomid(sid: cuserid, rid: event.rid);

    try {
      FirebaseFirestore.instance
          .collection('Chatroom')
          .doc(chatroomid)
          .collection('msg')
          .add(newusermsg.tomap());
    } catch (e) {
      log(e.toString());
    }
  }

  FutureOr<void> getusermsg(
    ChatdetailgetmsgEvent event,
    Emitter<ChatdetailScreenState> emit,
  ) {
    try {
      _messageSubscription?.cancel();
      var msg = streamgetusermsg(event.rid);
      emit(Chatgetmsg(msg: msg));
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<QuerySnapshot> streamgetusermsg(String rid) {
    var cuserid = FirebaseAuth.instance.currentUser!.uid;

    //chat room id
    String chatroomid = createchatroomid(sid: cuserid, rid: rid);

    return FirebaseFirestore.instance
        .collection('Chatroom')
        .doc(chatroomid)
        .collection('msg')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  // Fixed deleteusermsg method in your BLoC
  FutureOr<void> deleteusermsg(
    DeletemsgEvent event,
    Emitter<ChatdetailScreenState> emit,
  ) async {
    var cuserid = FirebaseAuth.instance.currentUser!.uid;
    var chatroomid = createchatroomid(sid: cuserid, rid: event.rid);

    try {
      // Update the specific message document, not the chatroom
      await FirebaseFirestore.instance
          .collection('Chatroom')
          .doc(chatroomid)
          .collection('msg')
          .doc(event.msgid) // Target specific message
          .update({'isDeleted': true});

      log('Message deleted successfully');
    } catch (e) {
      log('Error deleting message: ${e.toString()}');
    }
  }

  createchatroomid({String? sid, String? rid}) {
    List chatroomlist = [sid, rid];
    chatroomlist.sort();
    return chatroomlist.join('_');
  }
}
