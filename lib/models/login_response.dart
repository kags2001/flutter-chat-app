import 'package:chat_app/models/user.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class LoginResponse {
    User usuario;
    String token;

    LoginResponse({
        required this.usuario,
        required this.token,
    });

    factory LoginResponse.fromJson(String str) => LoginResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory LoginResponse.fromMap(Map<String, dynamic> json) => LoginResponse(
        usuario: User.fromMap(json["usuario"]),
        token: json["token"],
    );

    Map<String, dynamic> toMap() => {
        "usuario": usuario.toMap(),
        "token": token,
    };
}
