import 'package:exch_book/models/book.dart';
import 'package:exch_book/views/home_page.dart';
import 'package:exch_book/views/register_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:exch_book/services/rest_api_service.dart';
import 'package:flutter/material.dart';

class OfferDialogController {
  OfferDialogController(this.api);

  late List<Book> books;

  final formKey = GlobalKey<FormState>();
  final ApiService api;
  var state = ''.obs;

  createOffer({userto, bookfrom, bookto}) async {
    final box = GetStorage();
    final id = box.read('user_id');
    final res = await api.createOffer(
        userfrom: id, userto: userto, bookfrom: bookfrom, bookto: bookto);

    if (res != 'error') {
      Get.back();
      Get.back();

      Get.snackbar('Oferta de troca criada', 'Agora basta esperar aceitar!');
    }
  }

  fetch() async {
    state.value = 'loading';

    try {
      books = await api.fetchBooks2();
      state.value = 'sucess';
      print('aaaaaaaaa');
    } catch (e) {
      state.value = 'error';
    }
  }
}
