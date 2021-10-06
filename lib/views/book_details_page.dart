import 'package:exch_book/models/book.dart';
import 'package:exch_book/util/constants.dart';
import 'package:flutter/material.dart';

class BookDetailsPage extends StatelessWidget {
  late final Book book;
  BookDetailsPage(this.book);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        centerTitle: true,
        title: Text(book.title),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
                padding: EdgeInsets.all(size.height * 0.02),
                height: size.height * 0.4,
                child: Image.asset('images/book.jpg')),
          ),
          Center(
            child: Text(
              book.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, top: 26),
            child: Text(
              'Descrição: ' + book.description,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, top: 26, bottom: 4),
            child: Text(
              'Informações de troca:',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.grey[700]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
            child: Text(
              'Cidade: ' + book.location,
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
            child: Text(
              'Conservação: ' + book.conservationState,
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 8,
            ),
            child: Text(
              'Categoria: ' + book.category,
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              width: size.width * 0.8,
              height: size.height * 0.08,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Constants.secondaryColor),
                  onPressed: () => {},
                  child: Text(
                    'Propor troca',
                    style: TextStyle(fontSize: 20),
                  )),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      )),
    );
  }
}
