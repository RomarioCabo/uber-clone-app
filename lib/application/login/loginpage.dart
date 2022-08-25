import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:uber_clone/application/util/custombuttom.dart';
import 'package:uber_clone/application/util/textfield.dart';

import '../../domain/store/login/logincontroller.dart';
import '../../infrastructure/helpers/requeststate.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginController _controller;

  late final TextEditingController _controllerEmail;
  late final TextEditingController _controllerPassword;

  /// Reactions
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();

    _controller = LoginController();

    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();

    _controllerEmail.text = "romariocabo2012@gmail.com";
    _controllerPassword.text = "123456";

    /// Reações
    _disposers.add(
      reaction(
        (_) => _controller.stateAuthenticate,
        _stateAuthenticate,
      ),
    );
  }

  @override
  void dispose() {
    for (var disposer in _disposers) {
      disposer();
    }
    super.dispose();
  }

  void _stateAuthenticate(_) {
    if (_controller.stateAuthenticate is Completed) {
      if (_controller.user.typeUser == "PASSENGER") {
        Navigator.pushNamedAndRemoveUntil(
            context, "/panel-passenger", (_) => false);
      }

      if (_controller.user.typeUser == "DRIVER") {
        Navigator.pushNamedAndRemoveUntil(
            context, "/panel-driver", (_) => false);
      }
    }

    if (_controller.stateAuthenticate is Error) {
      alert(
        context,
        title: const Text('Atenção'),
        content: Text((_controller.stateAuthenticate as Error).error!),
        textOK: const Text('FECHAR'),
      );
    }
  }

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
            child: Observer(
              builder: (_) {
                return _buildMainContent();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
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
          enabled: _controller.stateAuthenticate is Initial,
        ),
        CustomTextField(
          controller: _controllerPassword,
          hintText: "Senha",
          obscureText: true,
          keyboardType: TextInputType.emailAddress,
          enabled: _controller.stateAuthenticate is Initial,
        ),
        CustomButtom(
          text: "Entrar",
          color: 0xff1ebbd8,
          loading: _controller.stateAuthenticate is Loading,
          onPressed: () {
            if (_controllerEmail.text.trim().isNotEmpty &&
                _controllerPassword.text.trim().isNotEmpty) {
              _controller.authenticate(
                _controllerEmail.text.trim(),
                _controllerPassword.text.trim(),
              );
            }
          },
          enable: _controller.stateAuthenticate is! Loading,
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
    );
  }
}
