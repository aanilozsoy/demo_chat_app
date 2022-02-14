import 'package:flutter/material.dart';

class DontHaveAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 15.0),
            height: 35.0,
            width: 175.0,
            decoration: BoxDecoration(
              color: Color(0xFFA3A3A3),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(0, 2),
                  blurStyle: BlurStyle.normal,
                  blurRadius: 3.0,
                  spreadRadius: 0.5,
                ),
              ],
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8, left: 27),
            child: Text(
              'Don\'t have an account ?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
