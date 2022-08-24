import 'package:flutter/material.dart';
import 'package:uber_clone/ui/pages/signin/signinpage.dart';
import 'package:uber_clone/ui/pages/util/custombuttom.dart';
import 'package:uber_clone/ui/pages/util/textfield.dart';

import '../util/messageerror.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("imagens/fundo.png"),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    "imagens/logo.png",
                    width: 200,
                    height: 150,
                  ),
                ),
                CustomTextField(
                  controller: _controllerEmail,
                  obscureText: false,
                  hintText: "E-mail",
                  keyboardType: TextInputType.emailAddress,
                  enabled: true,
                ),
                CustomTextField(
                  controller: _controllerPassword,
                  hintText: "Senha",
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  enabled: true,
                ),
                CustomButtom(
                  text: "Entrar",
                  color: 0xff1ebbd8,
                  onPressed: () {},
                ),
                Center(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInPage(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text(
                          "Não tem conta? cadastre-se!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                /*const MessageError(
                  messageError: "Error",
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
