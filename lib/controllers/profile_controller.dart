import 'package:exch_book/models/book.dart';
import 'package:exch_book/views/home_page.dart';
import 'package:exch_book/views/register_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:exch_book/services/rest_api_service.dart';
import 'package:flutter/material.dart';

class ProfileController {
  ProfileController(this.api);

  final formKey = GlobalKey<FormState>();
  final ApiService api;
  var state = ''.obs;
  late List<Map<String, dynamic>> offers;

  String name = '';
  String city = '';
  String phone = '';
  String password = '';
  late int id;
  fetch() async {
    final box = GetStorage();

    id = box.read('user_id');

    name = id.toString();

    offers = await api.fetchOffers(id);
    if (offers[0]['id'] > 0 || offers == []) {
      state.value = 'sucess';
      print(offers.length);
    } else {
      state.value = 'error';
    }
  }
}
