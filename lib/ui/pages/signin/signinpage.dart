import 'package:flutter/material.dart';

import '../util/custombuttom.dart';
import '../util/messageerror.dart';
import '../util/textfield.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPaheState();
}

class _SignInPaheState extends State<SignInPage> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool _tipoUsuarioPassageiro = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CustomTextField(
                  controller: _controllerName,
                  hintText: "Nome",
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  enabled: true,
                ),
                CustomTextField(
                  controller: _controllerLastName,
                  hintText: "Sobrenome",
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  enabled: true,
                ),
                CustomTextField(
                  controller: _controllerEmail,
                  hintText: "E-mail",
                  obscureText: false,
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: <Widget>[
                      const Text("Passageiro"),
                      Switch(
                          value: _tipoUsuarioPassageiro,
                          onChanged: (bool valor) {
                            setState(() {
                              _tipoUsuarioPassageiro = valor;
                            });
                          }),
                      const Text("Motorista"),
                    ],
                  ),
                ),
                CustomButtom(
                  text: "Cadastrar",
                  color: 0xff1ebbd8,
                  onPressed: () {},
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

