import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_chatapp/chatdetail_screen/chatdetail_screen.dart';
import 'package:test_chatapp/contactdetail_screen/contactdetail_screen.dart';
import 'package:test_chatapp/login_screen/bloc/login_screen_bloc.dart';
import 'package:test_chatapp/signup_screen/signup_screen.dart';

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Please enter your details to sign in',
                      style: TextStyle(fontSize: 15, color: Colors.black87),
                    ),
                    SizedBox(height: 50),
                    TextFormField(
                      controller: emailcontroller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: const OutlineInputBorder(),
                        hintText: "Email",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      obscureText: true,
                      controller: passcontroller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: const OutlineInputBorder(),
                        hintText: "Password",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: Colors.black87,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            Colors.black,
                          ),
                        ),
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
                                : Center(
                                  child: Text(
                                    'Sign in',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                      ),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap:
                          () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(),
                            ),
                          ),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Don't have an account yet? ",
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
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
