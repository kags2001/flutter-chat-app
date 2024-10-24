import 'package:flutter/material.dart';

class LabelLoginWidget extends StatelessWidget {
  final String route;
  final bool isLogin;
  const LabelLoginWidget({super.key, required this.route, this.isLogin = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          isLogin ?
          '¿No tienes cuenta?':
          '¿Ya tienes cuenta?'
          ,
          style: const TextStyle(
              color: Colors.black54,
              fontSize: 15,
              fontWeight: FontWeight.w300),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: (){
            Navigator.pushReplacementNamed(context, route);
          },
          child: Text(
            isLogin ?
            'Crea una ahora!':
            'Ingresa con la misma!',
            style: TextStyle(
                color: Colors.blue[600],
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ),
      ],
    );
  }
}
