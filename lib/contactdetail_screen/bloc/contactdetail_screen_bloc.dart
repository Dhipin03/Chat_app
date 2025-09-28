import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_chatapp/chatdetail_screen/bloc/chatdetail_screen_bloc.dart';
import 'package:test_chatapp/contactdetail_screen/bloc/contactdetail_screen_event.dart';
import 'package:test_chatapp/contactdetail_screen/bloc/contactdetail_screen_state.dart';

class ContactdetailScreenBloc
    extends Bloc<ContactdetailScreenEvent, ContactdetailScreenState> {
  ContactdetailScreenBloc() : super(ContactdetailScreenInitial()) {
    on<UserLogoutEvent>(_userlogout);
    on<UserDetailsEvent>(getuserdetails);
    on<GetUnseenmsgcountEvent>(getunseenmsgcount);
    on<markmsgasseen>(_markmsgseen);
  }

  Future<void> _userlogout(
    ContactdetailScreenEvent event,
    Emitter<ContactdetailScreenState> emit,
  ) async {
    try {
      await FirebaseAuth.instance.signOut();
      emit(UserlogoutSuccess());
    } catch (e) {
      log(e.toString());
      emit(LogoutError());
    }
  }

  FutureOr<void> getuserdetails(
    UserDetailsEvent event,
    Emitter<ContactdetailScreenState> emit,
  ) {
    try {
      var user = getstreamuserdetails();
      emit(GetuserDetail(user: user));
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<List<Map<String, dynamic>>> getstreamuserdetails() {
    return FirebaseFirestore.instance.collection('Userdetails').snapshots().map(
      (event) {
        return event.docs.map((e) {
          return e.data();
        }).toList();
      },
    );
  }

  // Event handler for bloc events
  FutureOr<void> getunseenmsgcount(
    GetUnseenmsgcountEvent event,
    Emitter<ContactdetailScreenState> emit,
  ) {
    try {
      var cuserid = FirebaseAuth.instance.currentUser!.uid;
      String chatroomid = createchatroomid(sid: cuserid, rid: event.rid);
      var unseenmsgcount = FirebaseFirestore.instance
          .collection('Chatroom')
          .doc(chatroomid)
          .collection('msg')
          .where('rid', isEqualTo: cuserid)
          .where('isSeen', isEqualTo: false)
          .snapshots()
          .map((event) => event.docs.length);
      emit(GetUnseenMsgCountState(count: unseenmsgcount));
    } catch (e) {
      log(e.toString());
    }
  }

  // Method to get unseen message count stream - this is what you need in the UI
  Stream<int> getUnseenMessageCount(String contactUid) {
    final currentUserUid = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserUid == null) return Stream.value(0);

    String chatroomId = createchatroomid(sid: currentUserUid, rid: contactUid);

    return FirebaseFirestore.instance
        .collection('Chatroom')
        .doc(chatroomId)
        .collection('msg')
        .where(
          'rid',
          isEqualTo: currentUserUid,
        ) // Messages received by current user
        .where('isSeen', isEqualTo: false) // Unseen messages
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  // Helper method to create chatroom ID
  String createchatroomid({String? sid, String? rid}) {
    List chatroomlist = [sid, rid];
    chatroomlist.sort();
    return chatroomlist.join('_');
  }

  FutureOr<void> _markmsgseen(
    markmsgasseen event,
    Emitter<ContactdetailScreenState> emit,
  ) {
    var cuserid = FirebaseAuth.instance.currentUser!.uid;
    var chatroomid = createchatroomid(sid: cuserid, rid: event.rid);

    try {
      FirebaseFirestore.instance
          .collection('Chatroom')
          .doc(chatroomid)
          .collection('msg')
          .where('sid', isEqualTo: event.rid) // Messages from the other user
          .where('isSeen', isEqualTo: false) // Only unseen messages
          .get()
          .then((querySnapshot) {
            for (var doc in querySnapshot.docs) {
              doc.reference.update({'isSeen': true});
            }
          });
    } catch (e) {
      log(e.toString());
    }
  }
}
