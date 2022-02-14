import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({required this.title, required this.onPressed});

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: 7.0,
        child: MaterialButton(
          onPressed: onPressed,
          padding: EdgeInsets.zero,
          minWidth: 200.0,
          height: 42.0,
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: title == 'Log In'
                      ? [(const Color(0xFFDEDFE0)), (const Color(0xFF595959))]
                      : [(const Color(0xFF595959)), (const Color(0xFFDEDFE0))],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Container(
              height: 49.0,
              alignment: Alignment.center,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
