import 'package:chat_app/globals/enviroments.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/models/usuarios_response.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:http/http.dart' as http;

class UsuariosService {

  Future<List<User>>getUsers() async {
    try{
      final url = Uri.http(Enviroment.apiUrl, 'api/user');

      final response = await http.get(url, headers: {
        'Content-type' : 'application/json',
        'x-token': await AuthService.getToken() ?? ''
      });

      final userResponse = UsuariosResponse.fromJson(response.body);

      return userResponse.usuarios;
    }catch(e){
      return [];
    }
  }
}