import 'package:demo_chat_app/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:demo_chat_app/screens/welcome_screen.dart';
import 'package:demo_chat_app/screens/login_screen.dart';
import 'package:demo_chat_app/screens/registration_screen.dart';
import 'package:demo_chat_app/screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DemoChatApp());
}

class DemoChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Splash.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        Splash.id: (context) => Splash(),
      },
    );
  }
}
