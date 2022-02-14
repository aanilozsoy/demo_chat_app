import 'package:demo_chat_app/screens/welcome_screen.dart';
import 'package:demo_chat_app/widgets/custom_page_route.dart';
import 'package:flutter/material.dart';
import 'welcome_screen.dart';

class Splash extends StatefulWidget {
  static String id = 'splash';

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {});
    Navigator.of(context).push(CustomPageRoute(child: WelcomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4D4D4D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(60.0)),
              child: Container(
                child: const Image(
                  image: AssetImage('images/demo_img.jpg'),
                ),
                height: 70.0,
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Container(
              child: const Text(
                'DEMO',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
