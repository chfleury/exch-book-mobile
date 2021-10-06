import 'dart:convert';

import 'package:exch_book/models/book.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = 'http://10.0.2.2:3333';
  final client = http.Client();

  Future login({
    @required email,
    @required password,
  }) async {
    final url = Uri.parse('$baseUrl/login');
    Map<String, dynamic> data = {
      'email': email,
      'password': password,
    };
    try {
      var response = await client.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data));

      if (jsonDecode(response.body)['message'] ==
          'successfully authenticated') {
        return jsonDecode(response.body)['token'];
      } else {
        return 'error';
      }
    } catch (e) {
      return 'error';
    }
  }

  Future fetchBooks() async {
    final url = Uri.parse('$baseUrl/books');

    final response = await client.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      List<Book> books = [];
      body.forEach((e) => {books.add(Book.fromJson(e))});

      return books;
    } else {
      throw Exception('Failed to load album');
    }
  }

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
      'location': city
    };

    try {
      final response = await client.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data));

      return jsonDecode(response.body)['id'];
    } catch (e) {
      return 'error';
    }
  }
}
