import 'package:exch_book/models/book.dart';
import 'package:exch_book/views/home_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:exch_book/services/rest_api_service.dart';
import 'package:flutter/material.dart';

class HomeController {
  HomeController(this.api);

  final ApiService api;
  var state = 'init'.obs;
  late List<Book> books;

  fetch(String category) async {
    state.value = 'loading';

    try {
      books = await api.fetchBooks(category);
      state.value = 'sucess';
    } catch (e) {
      state.value = 'error';
    }
  }
}
