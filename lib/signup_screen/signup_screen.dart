import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_chatapp/chatdetail_screen/chatdetail_screen.dart';
import 'package:test_chatapp/contactdetail_screen/contactdetail_screen.dart';
import 'package:test_chatapp/login_screen/login_screen.dart';
import 'package:test_chatapp/signup_screen/bloc/signup_screen_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController emailcontroller = TextEditingController();
    TextEditingController passcontroller = TextEditingController();
    TextEditingController confirmpasscontroller = TextEditingController();
    return BlocConsumer<SignupScreenBloc, SignupScreenState>(
      listener: (context, state) {
        if (state is SignupScreenSucees) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ContactdetailScreen()),
          );
        }
        if (state is SignupScreenError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errormsg ?? 'Error in signup')),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'SignUp',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40),
                  const SizedBox(height: 10), // Add spacing between elements
                  TextFormField(
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      final emailRegExp = RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      );
                      if (!emailRegExp.hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    controller: emailcontroller,
                    keyboardType:
                        TextInputType.emailAddress, // Changed to emailAddress
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintText: "Email",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30), // Add spacing between fields
                  TextFormField(
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (value.length <= 6) {
                        return 'Password length > 6';
                      }
                      return null;
                    },
                    controller: passcontroller,
                    obscureText: true, // Hide password
                    keyboardType:
                        TextInputType.text, // Changed from number to text
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintText: "Password",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30), // Add spacing between fields
                  TextFormField(
                    controller: confirmpasscontroller,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (value.length <= 6) {
                        return 'Password length > 6';
                      }
                      if (value != confirmpasscontroller.text) {
                        return 'Password not match';
                      }
                      return null;
                    },
                    obscureText: true, // Hide password
                    keyboardType:
                        TextInputType.text, // Changed from number to text
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintText: "Confirm Password",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Add spacing before button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(
                        double.infinity,
                        50,
                      ), // Make button wider
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Process data.
                        context.read<SignupScreenBloc>().add(
                          Signupevent(
                            useremail: emailcontroller.text,
                            userpassword: passcontroller.text,
                          ),
                        );
                      }
                    },
                    child:
                        state is SignupScreenLoading
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : const Text(
                              'Signup',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                  ),
                  SizedBox(height: 30),
                  InkWell(
                    onTap:
                        () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          TextSpan(
                            text: 'Sign in',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
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
        );
      },
    );
  }
}
