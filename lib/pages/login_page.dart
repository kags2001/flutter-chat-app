import 'package:chat_app/helpers/show_alert.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/widgets/button_login.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/label_login_widget.dart';
import 'package:chat_app/widgets/logo_login_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LogoLoginWidget(
                    text: 'Messenger',
                  ),
                  _Form(),
                  LabelLoginWidget(
                    route: 'register',
                  ),
                  Text(
                    'Terminos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  const _Form();

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.email,
            placeHolder: 'Correo',
            textEditingController: emailCtrl,
            keyBoardType: TextInputType.emailAddress,
          ),
          CustomInput(
            icon: Icons.remove_red_eye,
            placeHolder: 'Password',
            textEditingController: passwordCtrl,
            isPassword: true,
          ),
          ButtonLogin(
            onPressed: authService.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginOk = await authService.login(
                        emailCtrl.text.trim(), passwordCtrl.text.trim());
                    if (loginOk) {
                      socketService.connectSocket();
                      Navigator.pushReplacementNamed(context, 'users');
                    } else {
                      showAlertPersonilize(context, 'Login incorrecto', 'Revise sus credenciales nuevamente');
                    }
                  },
            text: 'Ingrese',
          )
        ],
      ),
    );
  }
}
