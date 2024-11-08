import 'dart:convert';

import 'package:chat_app/models/user.dart';

class UsuariosResponse {
  bool ok;
  List<User> usuarios;

  UsuariosResponse({
    required this.ok,
    required this.usuarios,
  });

  factory UsuariosResponse.fromJson(String str) => UsuariosResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsuariosResponse.fromMap(Map<String, dynamic> json) => UsuariosResponse(
    ok: json["ok"],
    usuarios: List<User>.from(json["usuarios"].map((x) => User.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "ok": ok,
    "usuarios": List<dynamic>.from(usuarios.map((x) => x.toMap())),
  };
}
