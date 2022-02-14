import 'package:demo_chat_app/screens/login_screen.dart';
import 'package:demo_chat_app/screens/registration_screen.dart';
import 'package:demo_chat_app/widgets/login_logo.dart';
import 'package:demo_chat_app/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import '../widgets/dont_have_account.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    animation =
        ColorTween(begin: Colors.black, end: Colors.white).animate(controller);

    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            LoginLogo(),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
                title: 'Log In',
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                }),
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: DontHaveAccount()),
                  const Icon(
                    FontAwesomeIcons.arrowRight,
                    size: 20.0,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegistrationScreen.id);
                    },
                    child: const Text(
                      'Sign Up !',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
