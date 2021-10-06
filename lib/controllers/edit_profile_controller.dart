import 'package:exch_book/views/home_page.dart';
import 'package:exch_book/views/register_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:exch_book/services/rest_api_service.dart';
import 'package:flutter/material.dart';

class EditProfileControler {
  EditProfileControler(this.api);

  final formKey = GlobalKey<FormState>();
  final ApiService api;
  var state = ''.obs;

  String email = '';
  String name = '';
  String city = '';
  String phone = '';
  String password = '';

  save() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      state.value = 'loading';

      final userId = await api.editUser(
          email: email,
          phone: phone,
          name: name,
          password: password,
          city: city);

      if (userId == 'error') {
        state.value = 'err or';
        return;
      }

      Get.back();
    }
  }
}
