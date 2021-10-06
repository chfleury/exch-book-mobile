import 'package:exch_book/services/rest_api_service.dart';
import 'package:exch_book/util/constants.dart';
import 'package:exch_book/views/login_page.dart';
import 'package:exch_book/views/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());

  // final x = ApiService();

  // await x.createUser(
  //     password: '123',
  //     name: 'jairo',
  //     email: 'a@gmai.com',
  //     phone: '912912912',
  //     city: 'anapolis');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Constants.title,
      theme: ThemeData(
          primaryColor: Constants.primaryColor,
          secondaryHeaderColor: Constants.secondaryColor),
      home: LoginPage(),
    );
  }
}
