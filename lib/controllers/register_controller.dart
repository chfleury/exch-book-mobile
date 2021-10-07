import 'package:exch_book/models/book.dart';
import 'package:exch_book/views/home_page.dart';
import 'package:exch_book/views/register_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:exch_book/services/rest_api_service.dart';
import 'package:flutter/material.dart';

class RegisterController {
  RegisterController(this.api);

  final formKey = GlobalKey<FormState>();
  final ApiService api;
  var state = ''.obs;
  late List<Book> books;

  String email = '';
  String name = '';
  String city = '';
  String phone = '';
  String password = '';

  register() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      print(email + ' ' + password);
      state.value = 'loading';

      final userId = await api.createUser(
          email: email,
          phone: phone,
          name: name,
          password: password,
          city: city);

      if (userId == 'error') {
        state.value = 'error';
        return;
      }

      state.value = '';
      Get.back();
    }
  }
}
