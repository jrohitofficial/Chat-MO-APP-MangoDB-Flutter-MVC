import 'package:flutter_chat/global/environment.dart';
import 'package:flutter_chat/models/user_model.dart';
import 'package:flutter_chat/models/users_response.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:http/http.dart' as http;

class UsersService {
  Future<List<User>> getUsers() async {
    try {
      final response = await http
          .get(Uri.parse('${Environment.socketUrl}/api/users'), headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken() ?? 'Default Value',
      });

      final data = usersResponseFromJson(response.body);

      return data.users;
    } catch (e) {
      return [];
    }
  }
}
