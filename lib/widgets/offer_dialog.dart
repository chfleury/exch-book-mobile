import 'package:exch_book/controllers/offer_dialog_controller.dart';
import 'package:exch_book/models/book.dart';
import 'package:exch_book/services/rest_api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class OfferDialog extends StatefulWidget {
  // const OfferDialog({Key? key}) : super(key: key);
  late final Book book;
  OfferDialog(this.book);

  @override
  _OfferDialogState createState() => _OfferDialogState();
}

class _OfferDialogState extends State<OfferDialog> {
  final apiService = ApiService();
  late OfferDialogController controller;

  @override
  void initState() {
    controller = OfferDialogController(apiService);
    fetchBooks();
    super.initState();
  }

  fetchBooks() async {
    await controller.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(
                'Selecione o SEU livro para essa troca',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Obx(() {
              if (controller.state.value == 'loading') {
                return Center(
                  child: LinearProgressIndicator(),
                );
              } else if (controller.state.value == 'sucess') {
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        ListTile(
                          onTap: () async {
                            print('tap');
                            await controller.createOffer(
                                bookfrom: controller.books[index].id,
                                bookto: widget.book,
                                userto: widget.book.userId);

                            print('taṕ2');
                          },
                          title: Text(
                            controller.books[index].title,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Divider(),
                      ],
                    );
                  },
                  itemCount: controller.books.length,
                );
              } else if (controller.state.value == 'error') {
                return Text(
                  'Verifique sua conexão com a internet',
                  style: TextStyle(color: Colors.red),
                );
              } else {
                return Container();
              }
            })
          ],
        ),
      ),
    );
  }
}
