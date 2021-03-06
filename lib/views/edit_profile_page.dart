import 'dart:io';

import 'package:exch_book/controllers/add_book_controller.dart';
import 'package:exch_book/controllers/edit_profile_controller.dart';
import 'package:exch_book/services/rest_api_service.dart';
import 'package:exch_book/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final apiService = ApiService();
  late EditProfileControler controller;

  @override
  void initState() {
    controller = EditProfileControler(apiService);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: Text('Editar Perfil'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    child: TextFormField(
                      cursorColor: Colors.pink,
                      validator: (input) =>
                          input!.length < 1 ? 'Não pode estar vazio' : null,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                      ),
                      onSaved: (input) => controller.name = input!,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    child: TextFormField(
                      cursorColor: Colors.pink,
                      validator: (input) =>
                          input!.length < 1 ? 'Não pode estar vazio' : null,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      onSaved: (input) => controller.email = input!,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    child: TextFormField(
                      cursorColor: Colors.pink,
                      validator: (input) =>
                          input!.length < 1 ? 'Não pode estar vazio' : null,
                      decoration: InputDecoration(
                        labelText: 'Localização',
                      ),
                      onSaved: (input) => controller.city = input!,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    child: TextFormField(
                      cursorColor: Colors.pink,
                      obscureText: true,
                      validator: (input) =>
                          input!.length < 1 ? 'Não pode estar vazio' : null,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                      ),
                      onSaved: (input) => controller.password = input!,
                    ),
                  ),
                  SizedBox(height: size.height * 0.25),
                  Container(
                    width: size.width * 0.8,
                    height: size.height * 0.08,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Constants.secondaryColor),
                        onPressed: controller.save,
                        child: Text(
                          "Salvar",
                          style: TextStyle(fontSize: 20),
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Obx(() {
                    if (controller.state.value == 'loading') {
                      return LinearProgressIndicator();
                    } else if (controller.state.value == 'error') {
                      return Text(
                        'Erro, tente novamente',
                        style: TextStyle(color: Colors.red),
                      );
                    } else {
                      return Container();
                    }
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
