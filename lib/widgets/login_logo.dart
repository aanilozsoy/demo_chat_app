import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

// ignore: use_key_in_widget_constructors
class LoginLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Hero(
          tag: 'logo',
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(60.0)),
            child: Container(
              child: const Image(
                image: AssetImage('images/demo_img.jpg'),
              ),
              height: 70.0,
            ),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        TextLiquidFill(
          boxBackgroundColor: Colors.white,
          waveColor: Colors.black,
          boxHeight: 160.0,
          boxWidth: 200.0,
          text: 'Demo Chat App',
          textStyle: const TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
