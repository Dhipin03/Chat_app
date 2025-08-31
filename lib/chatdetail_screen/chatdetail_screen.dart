import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_chatapp/chatdetail_screen/bloc/chatdetail_screen_bloc.dart';

import 'package:test_chatapp/contactdetail_screen/contactdetail_screen.dart';

class ChatdetailScreen extends StatefulWidget {
  String email;
  String uid;
  ChatdetailScreen({super.key, required this.email, required this.uid});

  @override
  State<ChatdetailScreen> createState() => _ChatdetailScreenState();
}

class _ChatdetailScreenState extends State<ChatdetailScreen> {
  @override
  void initState() {
    context.read<ChatdetailScreenBloc>().add(
      ChatdetailgetmsgEvent(rid: widget.uid),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController msgcontroller = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.email),

        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ContactdetailScreen(),
              ),
            );
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: BlocBuilder<ChatdetailScreenBloc, ChatdetailScreenState>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                state is Chatgetmsg
                    ? Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: state.msg,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Error');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text('Loading ... ');
                          }

                          return ListView(
                            children:
                                snapshot.data!.docs
                                    .map((e) => _buildMessageItem(e))
                                    .toList(),
                          );
                        },
                      ),
                    )
                    : SizedBox.shrink(),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 19.0,
                          horizontal: 16.0,
                        ),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: msgcontroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Type a message',
                              hintStyle: TextStyle(color: Colors.grey),
                              enabledBorder: OutlineInputBorder(),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.green),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<ChatdetailScreenBloc>().add(
                          ChatdetailsndmsgEvent(
                            msg: msgcontroller.text,
                            rid: widget.uid,
                          ),
                        );
                        msgcontroller.clear();
                      },
                      icon: Icon(Icons.send),

                      color: Colors.green,
                      iconSize: 30,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['sid'] == FirebaseAuth.instance.currentUser!.uid;

    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isCurrentUser ? Colors.blue[600] : Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft:
                  isCurrentUser ? Radius.circular(16) : Radius.circular(4),
              bottomRight:
                  isCurrentUser ? Radius.circular(4) : Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
            ],
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          child: Text(
            data['msg'] ?? '',
            style: TextStyle(
              color: isCurrentUser ? Colors.white : Colors.black87,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
