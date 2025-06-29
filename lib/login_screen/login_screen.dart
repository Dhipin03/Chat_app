import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_chatapp/chatdetail_screen/chatdetail_screen.dart';
import 'package:test_chatapp/contactdetail_screen/contactdetail_screen.dart';
import 'package:test_chatapp/login_screen/bloc/login_screen_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailcontroller = TextEditingController();
    TextEditingController passcontroller = TextEditingController();
    return BlocConsumer<LoginScreenBloc, LoginScreenState>(
      listener: (context, state) {
        if (state is LoginScreenSucces) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ContactdetailScreen()),
          );
        }
        if (state is LoginScreenError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errormsg ?? 'Error in signup')),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    TextFormField(
                      controller: emailcontroller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: "Email",
                        enabledBorder: const OutlineInputBorder(),
                      ),
                    ),
                    TextFormField(
                      controller: passcontroller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: "Password",
                        enabledBorder: const OutlineInputBorder(),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: ElevatedButton(
                        clipBehavior: Clip.hardEdge,
                        onPressed: () {
                          context.read<LoginScreenBloc>().add(
                            UserloginEvent(
                              useremail: emailcontroller.text,
                              userpass: passcontroller.text,
                            ),
                          );
                        },
                        child:
                            state is LoginScreenLoading
                                ? Center(child: CircularProgressIndicator())
                                : Center(child: Text('Login')),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
