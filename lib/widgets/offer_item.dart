import 'package:exch_book/models/book.dart';
import 'package:exch_book/services/rest_api_service.dart';
import 'package:exch_book/util/constants.dart';
import 'package:exch_book/views/book_details_page.dart';
import 'package:exch_book/views/register_page.dart';
import 'package:exch_book/widgets/accepted_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class OfferItem extends StatelessWidget {
  late final Book book;
  late final int offerId;
  late final String phone;
  OfferItem({required this.book, required this.offerId, required this.phone});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final api = ApiService();

    return InkWell(
      onTap: () async {
        final boolean = await api.acceptOffer(offerId);

        if (boolean) {
          await showDialog(
              context: context, builder: (ctx) => AccepteDialog(phone));
        }
      },
      child: Card(
        child: Row(
          children: [
            Container(
                padding: EdgeInsets.all(size.height * 0.02),
                height: size.height * 0.3,
                width: size.width * 0.4,
                child: Image.network(
                    Constants.BASE_URL + '/files/' + book.imagePath)),
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
                          'Aceitar troca',
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
