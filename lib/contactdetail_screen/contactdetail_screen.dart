import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_chatapp/account_screen/account_screen.dart';
import 'package:test_chatapp/chatdetail_screen/bloc/chatdetail_screen_bloc.dart';
import 'package:test_chatapp/chatdetail_screen/chatdetail_screen.dart';
import 'package:test_chatapp/contactdetail_screen/bloc/contactdetail_screen_bloc.dart';
import 'package:test_chatapp/contactdetail_screen/bloc/contactdetail_screen_event.dart';
import 'package:test_chatapp/contactdetail_screen/bloc/contactdetail_screen_state.dart';
import 'package:test_chatapp/model/usermsg_model.dart';
import 'package:test_chatapp/signup_screen/signup_screen.dart';

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
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignupScreen()),
        );
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return BlocConsumer<ContactdetailScreenBloc, ContactdetailScreenState>(
      listener: (context, state) {
        if (state is UserlogoutSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignupScreen()),
          );
        }
      },
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
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AccountScreen(),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(Icons.key),
                      title: Text('Account'),
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
              'Link Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w900,
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
                          final user = users[index];
                          final isCurrentUser = user['uid'] == currentUser.uid;

                          // Skip current user
                          if (isCurrentUser) {
                            return SizedBox.shrink();
                          }

                          return InkWell(
                            onTap: () {
                              // Mark messages as seen when opening chat
                              context.read<ContactdetailScreenBloc>().add(
                                markmsgasseen(rid: user['uid'] ?? ''),
                              );

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => BlocProvider(
                                        create:
                                            (context) => ChatdetailScreenBloc(),
                                        child: ChatdetailScreen(
                                          email: user['name'] ?? '',
                                          uid: user['uid'] ?? '',
                                        ),
                                      ),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      user['name'] ?? '',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 30),
                                  // StreamBuilder to show unseen message count for this specific contact
                                  StreamBuilder<int>(
                                    stream: context
                                        .read<ContactdetailScreenBloc>()
                                        .getUnseenMessageCount(
                                          user['uid'] ?? '',
                                        ),
                                    builder: (context, countSnapshot) {
                                      // Show loading state
                                      if (countSnapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        );
                                      }

                                      // Get the unseen count
                                      final unseenCount =
                                          countSnapshot.data ?? 0;

                                      // Show badge if there are unseen messages
                                      if (unseenCount > 0) {
                                        return Container(
                                          padding: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                          constraints: BoxConstraints(
                                            minWidth: 24,
                                            minHeight: 24,
                                          ),
                                          child: Text(
                                            unseenCount > 99
                                                ? '99+'
                                                : unseenCount.toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      }

                                      // Show nothing if no unseen messages
                                      return SizedBox.shrink();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          final isCurrentUser =
                              users[index]['uid'] == currentUser.uid;
                          return !isCurrentUser
                              ? const SizedBox(height: 20)
                              : SizedBox.shrink();
                        },
                        itemCount: users.length,
                      );
                    },
                  )
                  : Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
