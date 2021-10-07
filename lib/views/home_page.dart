import 'package:exch_book/controllers/home_controller.dart';
import 'package:exch_book/models/book.dart';
import 'package:exch_book/services/rest_api_service.dart';
import 'package:exch_book/util/constants.dart';
import 'package:exch_book/views/add_book_page.dart';
import 'package:exch_book/views/edit_profile_page.dart';
import 'package:exch_book/widgets/book_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final apiService = ApiService();
  late HomeController controller;

  @override
  void initState() {
    controller = HomeController(apiService);
    fetchBooks();
    super.initState();
  }

  fetchBooks() async {
    await controller.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.secondaryColor,
        onPressed: () => Get.to(AddBookPage()),
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: Icon(Icons.person_outlined),
          onPressed: () => Get.to(EditProfilePage()),
        ),
        title: Text('Livros disponíveis'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.state.value == 'loading') {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.state.value == 'error') {
          return Text(
            'Verifique suas credenciais ou conexão com a internet',
            style: TextStyle(color: Colors.red),
          );
        } else if (controller.state.value == 'sucess') {
          print('sucess');
          return ListView.builder(
            itemBuilder: (context, index) {
              print(controller.books);
              return BookItem(controller.books[index]);
            },
            itemCount: controller.books.length,
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
