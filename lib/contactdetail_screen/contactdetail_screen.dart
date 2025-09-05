import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_chatapp/chatdetail_screen/bloc/chatdetail_screen_bloc.dart';
import 'package:test_chatapp/chatdetail_screen/chatdetail_screen.dart';
import 'package:test_chatapp/contactdetail_screen/bloc/contactdetail_screen_bloc.dart';
import 'package:test_chatapp/contactdetail_screen/bloc/contactdetail_screen_event.dart';
import 'package:test_chatapp/contactdetail_screen/bloc/contactdetail_screen_state.dart';
import 'package:test_chatapp/model/usermsg_model.dart';

class ContactdetailScreen extends StatefulWidget {
  const ContactdetailScreen({super.key});

  @override
  State<ContactdetailScreen> createState() => _ContactdetailScreenState();
}

class _ContactdetailScreenState extends State<ContactdetailScreen> {
  @override
  void initState() {
    context.read<ContactdetailScreenBloc>().add(UserDetailsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactdetailScreenBloc, ContactdetailScreenState>(
      builder: (context, state) {
        return Scaffold(
          drawer: Drawer(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.message, color: Colors.green, size: 34),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      leading: Icon(Icons.home),
                      title: Text('Home'),
                    ),
                  ),

                  Spacer(),
                  InkWell(
                    onTap: () {
                      context.read<ContactdetailScreenBloc>().add(
                        UserLogoutEvent(),
                      );
                    },
                    child: ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Logout'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              FirebaseAuth.instance.currentUser!.email!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            backgroundColor: Colors.black,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          body:
              state is GetuserDetail
                  ? StreamBuilder<List<Map<String, dynamic>>>(
                    stream: state.user,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No users found'));
                      }

                      final users = snapshot.data!;

                      return ListView.separated(
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => BlocProvider(
                                        create:
                                            (context) => ChatdetailScreenBloc(),
                                        child: ChatdetailScreen(
                                          email: users[index]['email'],
                                          uid: users[index]['uid'],
                                        ),
                                      ),
                                ),
                              );
                            },
                            child:
                                users[index]['uid'] !=
                                        FirebaseAuth.instance.currentUser!.uid
                                    ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 10,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              users[index]['email'] ??
                                                  'No email',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 30),
                                          CircleAvatar(
                                            radius: 12,
                                            backgroundColor:
                                                Colors.grey.shade600,
                                            child: Text(
                                              '0',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    : SizedBox.shrink(),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return users[index]['uid'] !=
                                  FirebaseAuth.instance.currentUser!.uid
                              ? const SizedBox(height: 20)
                              : SizedBox.shrink();
                        },
                        itemCount:
                            users
                                .length, // Use actual length instead of hardcoded 100
                      );
                    },
                  )
                  : SizedBox(),
        );
      },
    );
  }
}
