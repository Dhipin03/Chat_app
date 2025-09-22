import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_chatapp/forgotPassword_screen/cubit/forgotpassword_screen_cubit.dart';
import 'package:test_chatapp/login_screen/login_screen.dart';

class ForgotpasswordScreen extends StatefulWidget {
  const ForgotpasswordScreen({super.key});

  @override
  State<ForgotpasswordScreen> createState() => _ForgotpasswordScreenState();
}

class _ForgotpasswordScreenState extends State<ForgotpasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotpasswordScreenCubit, ForgotpasswordScreenState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 60,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Forgot Password ?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextFormField(
                    controller: emailcontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.email),
                      hintStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w100,
                        color: Colors.grey.shade900,
                      ),
                      hintText: 'Email Address',
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.black),
                    ),
                    onPressed: () {
                      context
                          .read<ForgotpasswordScreenCubit>()
                          .SendPasswordResetLink(emailcontroller.text);
                      if (_formKey.currentState!.validate() &&
                          state is ForgotpasswordScreenSuccess) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Send Reset Link',
                      style: TextStyle(color: Colors.white),
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
