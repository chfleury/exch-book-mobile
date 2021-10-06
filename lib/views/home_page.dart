import 'package:exch_book/controllers/home_controller.dart';
import 'package:exch_book/models/book.dart';
import 'package:exch_book/services/rest_api_service.dart';
import 'package:exch_book/util/constants.dart';
import 'package:exch_book/widgets/book_item.dart';
import 'package:flutter/material.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: Icon(Icons.person_outlined),
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
          return ListView.builder(
            itemBuilder: (context, index) {
              return BookItem(
                Book(
                  location: 'Anápolis',
                  conservationState: 'novo',
                  title: 'O nome do vento',
                  category: 'Fantasia',
                  isActive: true,
                  description: 'livro maneiro',
                  id: 1,
                  userId: 1,
                  pictureId: 1,
                ),
              );
            },
            itemCount: 10,
          );
          // return ListView.builder(
          //   itemBuilder: (context, index) {
          //     return BookItem(controller.books[index]);
          //   },
          //   itemCount: controller.books.length,
          // );
        } else {
          return Container();
        }
      }),
    );
  }
}
