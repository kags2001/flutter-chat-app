import 'package:chat_app/widgets/button_login.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/label_login_widget.dart';
import 'package:chat_app/widgets/logo_login_widget.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
                  LogoLoginWidget(text: 'Registro',),
                  _Form(),
                  LabelLoginWidget(route: 'register', isLogin: false,),
                  Text(
                    'Terminos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w300),
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
  final nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.perm_identity,
            placeHolder: 'Nombre',
            textEditingController: nameCtrl,
            keyBoardType: TextInputType.text,
          ),
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
          ButtonLogin(onPressed: (){
            print(emailCtrl.text);
          }, text: 'Ingrese',)
        ],
      ),
    );
  }
}
