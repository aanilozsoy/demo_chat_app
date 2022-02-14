import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  CustomPageRoute({required this.child})
      : super(
            transitionDuration: const Duration(milliseconds: 1500),
            pageBuilder: (context, animation, secondaryAnimation) => child);

  Widget buildTransition(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      ScaleTransition(
        child: child,
        scale: animation,
      );
}
