import 'package:exch_book/models/book.dart';
import 'package:exch_book/util/constants.dart';
import 'package:exch_book/views/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class BookItem extends StatelessWidget {
  late final Book book;
  BookItem(this.book);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () => {Get.to(RegisterPage())},
      child: Card(
        child: Row(
          children: [
            Container(
                padding: EdgeInsets.all(size.height * 0.02),
                height: size.height * 0.3,
                child: Image.asset('images/book.jpg')),
            Container(
              height: size.height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    book.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Text("Conservação: " + book.conservationState),
                  Text('Gênero: ' + book.category),
                  Text("Localização: " + book.location),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Mais informações',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Constants.secondaryColor),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
