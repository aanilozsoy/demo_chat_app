import 'package:demo_chat_app/constants.dart';
import 'package:demo_chat_app/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:demo_chat_app/widgets/rounded_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // ignore: unused_field
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String email;
  late String password;
  late String nickname;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        print(user.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(75.0)),
                      child: Container(
                        height: 150.0,
                        child: const Image(
                          image: AssetImage('images/demo_img.jpg'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your email')),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password')),
            const SizedBox(
              height: 24.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                nickname = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter a nickname'),
            ),
            const SizedBox(
              height: 8.0,
            ),
            RoundedButton(
              onPressed: () async {
                try {
                  UserCredential userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: email, password: password);
                  if (userCredential != null) {
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }
              },
              title: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}
