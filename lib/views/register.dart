import 'package:exch_book/util/constants.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _senha = '';

  _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // _loginBloc.add(Login(email: _email, senha: _senha));
    }
  }

  @override
  void initState() {
    // _loginBloc = LoginBloc(repository);
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
              key: _formKey,
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
                      onSaved: (input) => _email = input!,
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
                      onSaved: (input) => _email = input!,
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
                      onSaved: (input) => _senha = input!,
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
                        onPressed: () => {},
                        child: Text(
                          Constants.register,
                          style: TextStyle(fontSize: 20),
                        )),
                  ), // BlocListener<LoginBloc, LoginState>(
                  //   bloc: _loginBloc,
                  //   listener: (context, state) {
                  //     if (state is LoginLoaded) {
                  //       Navigator.of(context)
                  //           .pushReplacementNamed(HomeScreen.id);
                  //     } else if (state is LoginError) {
                  //       print('Usuario ou senha invalidos');
                  //     }
                  //   },
                  //   child: BlocBuilder<LoginBloc, LoginState>(
                  //       bloc: _loginBloc,
                  //       builder: (context, state) {
                  //         if (state is LoginLoading) {
                  //           return Center(
                  //             child: LinearProgressIndicator(),
                  //           );
                  //         }
                  //         return GradientButton(
                  //             label: 'Entrar', onPressed: _submit);
                  //       }),
                  // ),
                  SizedBox(
                    height: 10,
                  ),

                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     Text('Ainda não possui uma conta?'),
                  //     // _buildRegisterButton(),
                  //   ],
                  // ),
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

// _buildRegisterButton() {
//   return Builder(builder: (context) {
//     return TextButton(
//       onPressed: () async {
//         var response = await Navigator.of(context).pushNamed(RegisterScreen.id);
//         if (response) {
//           Scaffold.of(context).showSnackBar(SnackBar(
//             content: Text(
//               'Conta criada com Sucesso',
//               style: TextStyle(
//                 fontSize: 18,
//               ),
//             ),
//             backgroundColor: Colors.green,
//           ));
//         }
//       },
//       child: Text(
//         'Registre-se',
//         style: TextStyle(
//           color: Colors.pink,
//         ),
//       ),
//     );
//   });
// }
