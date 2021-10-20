import 'dart:convert';
import 'dart:io';
import 'package:exch_book/util/constants.dart';
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
  static const baseUrl = Constants.BASE_URL;
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

  Future fetchBooks2() async {
    final box = GetStorage();
    var id = box.read('user_id');

    final url = Uri.parse('$baseUrl/bookuser/$id');
    final response = await client.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      List<dynamic> responseData = body;

      print(responseData[0]);
      List<Book> books = [];
      responseData.forEach((dynamic singleExercicio) {
        books.add(Book.fromJson(singleExercicio));
      });

      return books;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future acceptOffer(offerId) async {
    final url = Uri.parse('$baseUrl/offers/$offerId');

    Map<String, dynamic> data = {"is_accepted": true};
    final response = await client.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future fetchOffers(id) async {
    final url = Uri.parse('$baseUrl/offers/?user_to_id=$id&is_accepted=false');
    final response = await client.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      List<dynamic> responseData = body;

      print(responseData[0]);
      List<Map<String, dynamic>> offers = [];
      responseData.forEach((dynamic singleExercicio) {
        offers.add(singleExercicio);
      });

      return offers;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future fetchBooks(String category) async {
    final box = GetStorage();
    var id = box.read('user_id');

    final url = category != 'all'
        ? Uri.parse('$baseUrl/booknotuser/$id?category=$category')
        : Uri.parse('$baseUrl/booknotuser/$id');
    final response = await client.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      List<dynamic> responseData = body['rows'];

      print(responseData[0]);
      List<Book> books = [];
      responseData.forEach((dynamic x) {
        books.add(Book.fromJson(x));
      });

      print('aaaaaaaaaaa');
      print(books[0]);

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

  Future createOffer({
    @required userfrom,
    @required userto,
    @required bookfrom,
    @required bookto,
  }) async {
    final url = Uri.parse('$baseUrl/offers');
    Map<String, dynamic> data = {
      'user_from_id': userfrom,
      'user_to_id': userto,
      'book_from_id': bookfrom,
      'book_to_id': bookto.id,
      'is_accepted': false
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
