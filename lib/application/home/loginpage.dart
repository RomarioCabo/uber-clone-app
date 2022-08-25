import 'package:flutter/material.dart';
import 'package:uber_clone/application/util/custombuttom.dart';
import 'package:uber_clone/application/util/textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                  loading: false,
                  onPressed: () {},
                  enable: true,
                ),
                Center(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/create_account");
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
