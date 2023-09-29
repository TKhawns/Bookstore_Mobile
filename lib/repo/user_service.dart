import 'package:dio/dio.dart';
import '../database/dio_get.dart';

class UserService {
  Future<Response> signIn(String phone, String pass) async {
    return await BookClient.instance.dio.post("/user/login", data: {
      'email': phone,
      'password': pass,
    });
  }

  Future<Response> signUp(String displayName, String phone, String pass) {
    return BookClient.instance.dio.post('/user/register', data: {
      'full_name': displayName,
      'email': phone,
      'password': pass,
    });
  }
}
