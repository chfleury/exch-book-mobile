import 'package:exch_book/controllers/login_controller.dart';
import 'package:exch_book/services/rest_api_service.dart';
import 'package:exch_book/util/constants.dart';
import 'package:exch_book/views/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final apiService = ApiService();
  late LoginController controller;

  @override
  void initState() {
    controller = LoginController(apiService);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset('images/logo.png'),
              height: size.height * 0.1,
            ),
            Text(
              'ExchBook',
              style: TextStyle(
                  fontFamily: 'SIMPLIFICA Typeface',
                  fontSize: 30,
                  color: Colors.white),
            ),
            Form(
              key: controller.formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      validator: (input) => (input!.length > 5 &&
                              input.trim().length > 0 &&
                              input.contains('@'))
                          ? null
                          : 'Por favor insira um email válido',
                      decoration: InputDecoration(
                          labelText: 'E-mail',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          )),
                      onSaved: (input) => controller.email = input!,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.pink,
                      obscureText: true,
                      validator: (input) => input!.length < 6
                          ? 'A senha deve conter pelo menos 6 caracteres'
                          : null,
                      decoration: InputDecoration(
                          labelText: 'Senha',
                          labelStyle: TextStyle(color: Colors.white)),
                      onSaved: (input) => controller.password = input!,
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
                        onPressed: controller.login,
                        child: Text(
                          Constants.login,
                          style: TextStyle(fontSize: 20),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    if (controller.state.value == 'loading') {
                      return LinearProgressIndicator();
                    } else if (controller.state.value == 'error') {
                      return Text(
                        'Verifique suas credenciais ou conexão com a internet',
                        style: TextStyle(color: Colors.red),
                      );
                    } else {
                      return Container();
                    }
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      onPressed: () => {Get.to(RegisterPage())},
                      child: Text(
                        Constants.dontHaveAccount,
                        style: TextStyle(color: Colors.white),
                      ))
                ],
                mainAxisSize: MainAxisSize.min,
              ),
            )
          ],
        ),
      ),
    );
  }
}
