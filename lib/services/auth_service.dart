import 'dart:convert';

import 'package:chat_app/globals/enviroments.dart';
import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  bool _isLoading = false;
  late User user;
  final _storage = const FlutterSecureStorage();

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  static Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token;
  }

  static Future deleteToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    isLoading = true;

    final data = {'email': email, 'password': password};
    final url = Uri.http(Enviroment.apiUrl, 'api/login');

    final resp = await http.post(url,
        body: jsonEncode(data), headers: {'Content-type': 'application/json'});
    isLoading = false;

    if (resp.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(resp.body);
      user = loginResponse.usuario;

      _saveToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future register(String name, String email, String password) async {
    isLoading = true;

    final data = {'name': name, 'email': email, 'password': password};
    final url = Uri.http(Enviroment.apiUrl, 'api/login/new');

    final resp = await http.post(url,
        body: jsonEncode(data), headers: {'Content-type': 'application/json'});
    isLoading = false;

    if (resp.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(resp.body);
      user = loginResponse.usuario;

      _saveToken(loginResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');
    if(token == null){
      return false;
    }
    final url = Uri.http(Enviroment.apiUrl, 'api/login/renew');

    final resp = await http.get(url,
        headers: {'Content-type': 'application-json', 'x-token': token!});

    if (resp.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(resp.body);
      user = loginResponse.usuario;

      _saveToken(loginResponse.token);
      return true;
    }else{
      logOut();
      return false;
    }

  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logOut() async {
    await _storage.delete(key: 'token');
  }
}
