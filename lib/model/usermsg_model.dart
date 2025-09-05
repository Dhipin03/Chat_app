import 'package:cloud_firestore/cloud_firestore.dart';

class Usermsg {
  String? id;
  String rid;
  String sid;
  String msg;
  String email;
  final bool? isDeleted;

  Timestamp timestamp;
  Usermsg({
    this.id,
    required this.msg,
    required this.rid,
    required this.email,
    required this.sid,
    required this.timestamp,
    this.isDeleted = false,
  });

  Map<String, dynamic> tomap() {
    return {
      'rid': rid,
      'sid': sid,
      'msg': msg,
      'timestamp': timestamp,
      'email': email,
      'isDeleted': isDeleted ?? false,
    };
  }
}
