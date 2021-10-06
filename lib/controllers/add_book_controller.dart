import 'dart:io';

import 'package:exch_book/views/home_page.dart';
import 'package:exch_book/views/register_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:exch_book/services/rest_api_service.dart';
import 'package:flutter/material.dart';

class AddBookController {
  AddBookController(this.api);

  final formKey = GlobalKey<FormState>();
  final ApiService api;
  var state = ''.obs;
  var picState = ''.obs;

  late String title;
  late String conservationState;
  late String description;
  late String category;

  late int imageId;
  upload(File imageFile) async {
    await api.upload(imageFile);

    var a = 0;
    for (int i = 0; i < 100000; i++) {
      a += 1;
    }
    print('doneeeeeee');
    picState.value = 'done';
  }

  addBook() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      state.value = 'loading';

      final box = GetStorage();

      final userId = box.read('user_id');

      final imageId = box.read('image_id');

      await api.createBook(
          title: title,
          conservationState: conservationState,
          description: description,
          userId: userId,
          imageId: imageId,
          category: category);

      Get.back();

      Get.snackbar('Sucesso!', "Livro cadastrado com sucesso");
    }
  }
}
