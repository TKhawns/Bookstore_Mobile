// ignore_for_file: prefer_final_fields, unnecessary_null_comparison, unused_catch_clause, depend_on_referenced_packages

import 'dart:async';
import 'package:dio/dio.dart';

import 'author_data.dart';
import 'author_service.dart';

class AuthorRepo {
  AuthorService _authorService;
  AuthorRepo({required AuthorService authorService})
      : _authorService = authorService;

  Future<List<AuthorData>> authorList() async {
    var c = Completer<List<AuthorData>>();

    try {
      var response = await _authorService.authorInfo();
      var authorList = AuthorData.parseAuthorDataList(response.data);
      c.complete(authorList);
    } on DioException {
      c.completeError("Get author fail");
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }
}
