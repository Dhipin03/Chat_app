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
  ChatdetailScreenBloc() : super(ChatdetailScreenInitial()) {
    on<ChatdetailsndmsgEvent>(sendusermsg);
    on<ChatdetailgetmsgEvent>(getusermsg);
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
    List<String> idlist = [event.rid, cuserid];
    idlist.sort();
    String chatroomid = idlist.join('_');

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
      var msg = streamgetusermsg(event.rid);
      emit(Chatgetmsg(msg: msg));
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<QuerySnapshot> streamgetusermsg(String rid) {
    var cuserid = FirebaseAuth.instance.currentUser!.uid;

    //chat room id
    List<String> idlist = [rid, cuserid];
    idlist.sort();
    String chatroomid = idlist.join('_');

    return FirebaseFirestore.instance
        .collection('Chatroom')
        .doc(chatroomid)
        .collection('msg')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
