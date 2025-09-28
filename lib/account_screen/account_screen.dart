import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_chatapp/account_screen/bloc/accountscreen_bloc.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

TextEditingController namecontroller = TextEditingController();
TextEditingController emailcontroller = TextEditingController();
TextEditingController passcontroller = TextEditingController();
final key = GlobalKey<FormState>();

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    context.read<AccountscreenBloc>().add(CurrentUserDetailsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountscreenBloc, AccountscreenState>(
      builder: (context, state) {
        if (state is CurrentuserdetailsGet) {
          var userdetails = state.userdetails;
          namecontroller.text = userdetails['name'];
          emailcontroller.text = userdetails['email'];
          passcontroller.text = userdetails['pass'];
        }
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: () {
                  if (key.currentState!.validate()) {
                    context.read<AccountscreenBloc>().add(
                      UpdateUserDetailsEvent(
                        name: namecontroller.text,
                        email: emailcontroller.text,
                        pass: passcontroller.text,
                      ),
                    );
                    if (state is UpdateduserdetailsState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Profile Updated')),
                      );
                    }
                  }
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
            backgroundColor: Colors.black,
            title: Text("Profile"),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Form(
              key: key,
              child: Column(
                spacing: 20,
                children: [
                  TextFormField(
                    controller: namecontroller,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: emailcontroller,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: passcontroller,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
