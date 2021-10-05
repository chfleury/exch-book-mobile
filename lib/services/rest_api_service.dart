import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = 'http://localhost:3333';
  final client = http.Client();

  Future createUser(
      {@required email,
      @required phone,
      @required name,
      @required password,
      @required city}) async {
    final url = Uri.parse('$baseUrl/users');
    Map<String, dynamic> data = {
      'email': email,
      'phone': phone,
      'name': name,
      'password': password,
      'city': city
    };

    final response = await client.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data));

    return response;
  }
}
