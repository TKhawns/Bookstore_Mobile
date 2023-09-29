// ignore_for_file: prefer_final_fields, unnecessary_null_comparison, unused_catch_clause

import 'dart:async';

import 'package:bookstore_mobile/repo/user_data.dart';
import 'package:bookstore_mobile/repo/user_service.dart';
import 'package:dio/dio.dart';

import '../database/constant.dart';
import '../database/spref.dart';

class UserRepo {
  UserService _userService;
  UserRepo({required UserService userService}) : _userService = userService;

  Future<UserData> signIn(String phone, String pass) async {
    var c = Completer<UserData>();
    try {
      var response = await _userService.signIn(phone, pass);
      var userData = UserData.fromJson(response.data['data']);
      if (userData != null) {
        SPref.instance.set(SPrefCache.KEY_TOKEN, userData.token);
        c.complete(userData);
      }
    } on DioException catch (e) {
      c.completeError("Signin fail");
    }
    return c.future;
  }

  Future<UserData> signUp(String displayName, String phone, String pass) async {
    var c = Completer<UserData>();
    try {
      var response = await _userService.signUp(displayName, phone, pass);
      var userData = UserData.fromJson(response.data['data']);
      if (userData != null) {
        SPref.instance.set(SPrefCache.KEY_TOKEN, userData.token);
        c.complete(userData);
      }
    } on DioException catch (e) {
      c.completeError("Signup fail");
    }
    return c.future;
  }
}
