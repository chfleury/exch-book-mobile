import 'package:exch_book/controllers/register_controller.dart';
import 'package:exch_book/services/rest_api_service.dart';
import 'package:exch_book/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final apiService = ApiService();
  late RegisterController controller;

  @override
  void initState() {
    controller = RegisterController(apiService);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
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
                          validator: (input) =>
                              (input!.length > 3 && input.trim().length > 0)
                                  ? null
                                  : 'Por favor insira um nome válido',
                          decoration: InputDecoration(
                              labelText: 'Nome',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              )),
                          onSaved: (input) => controller.name = input!,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          validator: (input) =>
                              (input!.length > 5 && input.trim().length > 0)
                                  ? null
                                  : 'Por favor insira um telefone válido',
                          decoration: InputDecoration(
                              labelText: 'Telefone',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              )),
                          onSaved: (input) => controller.phone = input!,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          validator: (input) =>
                              (input!.length > 5 && input.trim().length > 0)
                                  ? null
                                  : 'Por favor insira uma cidade válida',
                          decoration: InputDecoration(
                              labelText: 'Cidade',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              )),
                          onSaved: (input) => controller.city = input!,
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
                        height: 20,
                      ),
                      Obx(() {
                        if (controller.state.value == 'loading') {
                          return LinearProgressIndicator();
                        } else if (controller.state.value == 'error') {
                          return Text(
                            'Erro, verifique se email está em uso e sua conexão.',
                            style: TextStyle(color: Colors.red),
                          );
                        } else {
                          return Container();
                        }
                      }),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: size.width * 0.8,
                        height: size.height * 0.08,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Constants.secondaryColor),
                            onPressed: controller.register,
                            child: Text(
                              Constants.register,
                              style: TextStyle(fontSize: 20),
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                    mainAxisSize: MainAxisSize.min,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
