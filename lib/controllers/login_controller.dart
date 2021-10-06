import 'package:exch_book/views/home_page.dart';
import 'package:exch_book/views/register.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:exch_book/services/rest_api_service.dart';
import 'package:flutter/material.dart';

class LoginController {
  LoginController(this.api);

  final formKey = GlobalKey<FormState>();
  final ApiService api;
  var state = ''.obs;

  String email = '';
  String password = '';

  login() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      print(email + ' ' + password);
      state.value = 'loading';

      final token = await api.login(email: email, password: password);
      if (token == 'error') {
        state.value = 'error';
        return;
      }

      final box = GetStorage();
      box.write('token', token);

      state.value = '';
      Get.off(() => HomePage());
    }
  }
}
