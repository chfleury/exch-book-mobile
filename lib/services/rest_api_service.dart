import 'dart:convert';
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
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
        return [
          jsonDecode(response.body)['token'],
          jsonDecode(response.body)['id']
        ];
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

  upload(File imageFile) async {
    // open a bytestream
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse(baseUrl + '/files');

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();

    if (response.statusCode == 200) {
      print(response.stream);
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
        final box = GetStorage();

        box.write('image_id', jsonDecode(value)['id']);
      });
    }
  }

  Future createBook(
      {@required title,
      @required conservationState,
      @required description,
      @required userId,
      @required imageId,
      @required category}) async {
    final url = Uri.parse('$baseUrl/books');

    Map<String, dynamic> data = {
      'title': title,
      'category': category,
      'conservation_state': conservationState,
      'description': description,
      'is_active': true,
      'user_id': userId,
      'image_id': imageId,
    };

    print(data);
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

  Future editUser(
      {@required email,
      @required phone,
      @required name,
      @required password,
      @required city}) async {
    final box = GetStorage();
    var id = box.read('user_id');

    final url = Uri.parse('$baseUrl/users/' + id);
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
