import 'package:demo_chat_app/constants.dart';
import 'package:demo_chat_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool _load = false;
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = _load
        ? Column(
            children: <Widget>[
              Container(
                color: Colors.white30,
                width: 70.0,
                height: 70.0,
                child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Center(child: CircularProgressIndicator())),
              ),
              const Text(
                'Logging you in, please wait',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              )
            ],
          )
        : Container();
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
                          const BorderRadius.all(const Radius.circular(75.0)),
                      child: Container(
                        child: const Image(
                          image: AssetImage('images/demo_img.jpg'),
                        ),
                        height: 150.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 65.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password')),
            const SizedBox(
              height: 24.0,
            ),
            Visibility(
              visible: isVisible,
              child: RoundedButton(
                onPressed: () async {
                  setState(() {
                    isVisible = false;
                    _load = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.pushNamed(context, ChatScreen.id);
                      });
                    }
                    Future.delayed(const Duration(seconds: 2), () {
                      setState(() {
                        _load = false;
                        isVisible = true;
                      });
                    });
                  } catch (e) {
                    // ignore: avoid_print
                    print(e);
                  }
                },
                title: 'Log In',
              ),
            ),
            Align(
              child: loadingIndicator,
              alignment: FractionalOffset.topCenter,
            ),
          ],
        ),
      ),
    );
  }
}
