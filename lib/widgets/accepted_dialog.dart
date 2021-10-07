import 'package:exch_book/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class AccepteDialog extends StatelessWidget {
  late final phone;
  AccepteDialog(this.phone);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                'Parabéns, troca aceita, o telefone a ser contatado é:',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(phone),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            width: size.width * 0.8,
            height: size.height * 0.08,
            child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(primary: Constants.secondaryColor),
                onPressed: () {
                  Get.back();
                  Get.back();
                },
                child: Text(
                  "Entendido",
                  style: TextStyle(fontSize: 20),
                )),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
