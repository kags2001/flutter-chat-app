import 'package:flutter/material.dart';

class LogoLoginWidget extends StatelessWidget {
  final String text;
  const LogoLoginWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        width: 170,
        child: Column(
          children: [
            Image.asset('assets/tag-logo.png'),
            const SizedBox(
              height: 20,
            ),
             Text(
              text,
              style: const TextStyle(fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
