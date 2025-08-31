import 'package:cloud_firestore/cloud_firestore.dart';

class Usermsg {
  String rid;
  String sid;
  String msg;
  String email;

  Timestamp timestamp;
  Usermsg({
    required this.msg,
    required this.rid,
    required this.email,
    required this.sid,
    required this.timestamp,
  });

  Map<String, dynamic> tomap() {
    return {
      'rid': rid,
      'sid': sid,
      'msg': msg,
      'timestamp': timestamp,
      'email': email,
    };
  }
}
