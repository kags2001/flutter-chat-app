import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  const ButtonLogin({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        elevation: 2,
        highlightElevation: 5,
        shape: const StadiumBorder(),
        color: Colors.blue,
        onPressed: onPressed,
        child: SizedBox(
          height: 55,
          width: double.infinity,
          child:  Center(
              child: Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              )),
        ));
  }
}
