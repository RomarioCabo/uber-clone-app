import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:uber_clone/application/util/custom_button.dart';
import 'package:uber_clone/application/util/text_field.dart';
import 'package:uber_clone/domain/argument/who_called.dart';
import 'package:uber_clone/domain/store/login/login_controller_impl.dart';

import '../../domain/argument/method_arguments.dart';
import '../../infrastructure/helpers/request_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginControllerImpl _controller;

  late final TextEditingController _controllerEmail;
  late final TextEditingController _controllerPassword;

  /// Reactions
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();

    _controller = LoginControllerImpl();

    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();

    //_controllerEmail.text = "romario_motorista@gmail.com";
    //_controllerPassword.text = "1234";

    _controllerEmail.text = "romario_passageiro@gmail.com";
    _controllerPassword.text = "1234";

    _controller.requestLocationPermission();

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
      _openPageByTypeUser();
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

  bool _isEnable() {
    return _controller.stateAuthenticate is Initial ||
        _controller.stateAuthenticate is Error;
  }

  void _openPageByTypeUser() {
    switch (_controller.user.typeUser) {
      case "PASSENGER":
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/fragment-main",
          (_) => false,
          arguments: MethodArguments(
            title: "Passageiro",
            whoCalled: WhoCalled.panelPassenger,
          ),
        );
        break;
      case "DRIVER":
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/fragment-main",
          (_) => false,
          arguments: MethodArguments(
            title: "Rotas Disponíveis",
            whoCalled: WhoCalled.routesUber,
          ),
        );
        break;
      default:
        break;
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
      children: [
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
          enabled: _isEnable(),
        ),
        CustomTextField(
          controller: _controllerPassword,
          hintText: "Senha",
          obscureText: true,
          keyboardType: TextInputType.emailAddress,
          enabled: _isEnable(),
        ),
        CustomButton(
          text: "ENTRAR",
          color: 0xff37474f,
          loading: _controller.stateAuthenticate is Loading,
          onPressed: () {
            _controller.authenticate(
              email: _controllerEmail.text.trim(),
              password: _controllerPassword.text.trim(),
            );
          },
          enable: _controller.stateAuthenticate is! Loading,
        ),
        Center(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/create-account");
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
