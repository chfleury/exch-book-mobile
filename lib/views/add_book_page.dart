import 'dart:io';

import 'package:exch_book/controllers/add_book_controller.dart';
import 'package:exch_book/services/rest_api_service.dart';
import 'package:exch_book/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<AddBookPage> {
  final apiService = ApiService();
  late AddBookController controller;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    controller = AddBookController(apiService);
    super.initState();
  }

  _pickImage() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    File file = File(photo!.path);

    bool x = controller.upload(file);
    if (x) {
      controller.picState.value = 'done';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: Text('Adicionar Livro'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: controller.formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Obx(() {
                    if (controller.picState.value != 'done') {
                      return Container(
                        width: size.width * 0.6,
                        height: size.height * 0.08,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Constants.primaryColor),
                            onPressed: _pickImage,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Adicione uma Foto'),
                                Icon(Icons.camera),
                              ],
                            )),
                      );
                    } else {
                      return Container(
                        width: size.width * 0.6,
                        height: size.height * 0.08,
                        child: ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.green),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Foto adicionada'),
                                Icon(Icons.camera),
                              ],
                            )),
                      );
                    }
                  }),
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
                        labelText: 'Título',
                      ),
                      onSaved: (input) => controller.title = input!,
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
                        labelText: 'Descrição',
                      ),
                      onSaved: (input) => controller.description = input!,
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
                        labelText: 'Conservação',
                      ),
                      onSaved: (input) => controller.conservationState = input!,
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
                        labelText: 'Categoria',
                      ),
                      onSaved: (input) => controller.category = input!,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: size.width * 0.8,
                    height: size.height * 0.08,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Constants.secondaryColor),
                        onPressed: controller.addBook,
                        child: Text(
                          "Adicionar Livro",
                          style: TextStyle(fontSize: 20),
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
