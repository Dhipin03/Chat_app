import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_chatapp/chatdetail_screen/chatdetail_screen.dart';
import 'package:test_chatapp/contactdetail_screen/bloc/contactdetail_screen_bloc.dart';
import 'package:test_chatapp/contactdetail_screen/bloc/contactdetail_screen_event.dart';
import 'package:test_chatapp/contactdetail_screen/bloc/contactdetail_screen_state.dart';

class ContactdetailScreen extends StatelessWidget {
  const ContactdetailScreen({super.key});

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
                    onTap: () {},
                    child: ListTile(
                      leading: Icon(Icons.home),
                      title: Text('Home'),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Settings'),
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

          appBar: AppBar(backgroundColor: Colors.green),
          body: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChatdetailScreen(),
                ),
              );
            },
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Row(
                    spacing: 30,

                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(
                          'https://images.pexels.com/photos/30327991/pexels-photo-30327991/free-photo-of-historic-fort-in-okzitanien-france.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                        ),
                      ),
                      Expanded(child: Text('Contact1')),
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Text(
                          '1',
                          style: TextStyle(color: Colors.lightGreen),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: 100,
            ),
          ),
        );
      },
    );
  }
}
