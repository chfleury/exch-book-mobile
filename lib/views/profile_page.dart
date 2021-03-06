import 'package:exch_book/controllers/profile_controller.dart';
import 'package:exch_book/models/book.dart';
import 'package:exch_book/services/rest_api_service.dart';
import 'package:exch_book/util/constants.dart';
import 'package:exch_book/views/edit_profile_page.dart';
import 'package:exch_book/widgets/book_item.dart';
import 'package:exch_book/widgets/offer_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final apiService = ApiService();
  late ProfileController controller;

  @override
  void initState() {
    controller = ProfileController(apiService);
    fetchC();
    super.initState();
  }

  fetchC() async {
    await controller.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Perfil'),
          centerTitle: true,
          backgroundColor: Constants.primaryColor),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Center(
              child: LayoutBuilder(builder: (context, constraint) {
                return new Icon(
                  Icons.person_pin,
                  size: 90,
                  color: Colors.grey,
                );
              }),
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  Get.to(EditProfilePage());
                },
                child: Text('Editar Perfil')),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                'Livros que querem trocar com voc??:',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Obx(() {
              if (controller.state.value == 'sucess') {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.offers.length,
                    itemBuilder: (ctx, index) {
                      final book = controller.offers[index]['book_from'];

                      return OfferItem(
                          phone: controller.offers[index]['user_from']['phone'],
                          offerId: controller.offers[index]['id'],
                          book: Book(
                            title: book['title'],
                            category: book['category'],
                            description: book['description'],
                            id: 1,
                            imagePath: book[' image']['path'],
                            conservationState: book['conservation_state'],
                            location: controller.offers[index]['user_from']
                                ['location'],
                            pictureId: 1,
                            isActive: true,
                            userId: 0,
                          ));
                    });
              } else if (controller.state.value == 'error') {
                return Text(
                  'Verifique suas credenciais ou conex??o com a internet',
                  style: TextStyle(color: Colors.red),
                );
              } else {
                return Container();
              }
            }),
          ],
        ),
      ),
    );
  }
}
