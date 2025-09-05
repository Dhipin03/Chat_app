import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_chatapp/authgate_screen/authgate.dart';
import 'package:test_chatapp/chatdetail_screen/bloc/chatdetail_screen_bloc.dart';
// ignore: unused_import
import 'package:test_chatapp/chatdetail_screen/chatdetail_screen.dart';
import 'package:test_chatapp/contactdetail_screen/bloc/contactdetail_screen_bloc.dart';
import 'package:test_chatapp/contactdetail_screen/contactdetail_screen.dart';
import 'package:test_chatapp/firebase_options.dart';
import 'package:test_chatapp/login_screen/bloc/login_screen_bloc.dart';
import 'package:test_chatapp/signup_screen/bloc/signup_screen_bloc.dart';
import 'package:test_chatapp/signup_screen/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignupScreenBloc()),
        BlocProvider(create: (context) => LoginScreenBloc()),
        BlocProvider(create: (context) => ContactdetailScreenBloc()),
        BlocProvider(create: (context) => ChatdetailScreenBloc()),
      ],
      child: MaterialApp(themeMode: ThemeMode.system, home: Authgate()),
    );
  }
}
