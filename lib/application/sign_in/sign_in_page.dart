import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:uber_clone/domain/store/sign_in/sign_in_controller_impl.dart';

import '../../infrastructure/helpers/request_state.dart';
import '../util/custom_button.dart';
import '../util/text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPaheState();
}

class _SignInPaheState extends State<SignInPage> {
  late SignInControllerImpl _controller;

  late final TextEditingController _controllerName;
  late final TextEditingController _controllerLastName;
  late final TextEditingController _controllerEmail;
  late final TextEditingController _controllerPassword;

  /// Reactions
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();

    _controller = SignInControllerImpl();

    _controllerName = TextEditingController();
    _controllerLastName = TextEditingController();
    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();

    /// Reações
    _disposers.add(
      reaction(
        (_) => _controller.stateSaveUser,
        _stateSave,
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

  void _stateSave(_) {
    if (_controller.stateSaveUser is Completed) {
      _clearFields();

      alert(
        context,
        title: const Text('Sucesso'),
        content: const Text('Registro salvo com sucesso!'),
        textOK: const Text('FECHAR'),
      );
    }

    if (_controller.stateSaveUser is Error) {
      alert(
        context,
        title: const Text('Atenção'),
        content: Text((_controller.stateSaveUser as Error).error!),
        textOK: const Text('FECHAR'),
      );
    }
  }

  void _clearFields() {
    _controllerName.text = "";
    _controllerLastName.text = "";
    _controllerEmail.text = "";
    _controllerPassword.text = "";
    _controller.tipoUsuarioPassageiro = false;
  }

  bool _isEnable() {
    return _controller.stateSaveUser is Initial ||
        _controller.stateSaveUser is Error ||
        _controller.stateSaveUser is Completed;
  }

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
        CustomTextField(
          controller: _controllerName,
          hintText: "Nome",
          obscureText: false,
          keyboardType: TextInputType.text,
          enabled: _isEnable(),
        ),
        CustomTextField(
          controller: _controllerLastName,
          hintText: "Sobrenome",
          obscureText: false,
          keyboardType: TextInputType.text,
          enabled: _isEnable(),
        ),
        CustomTextField(
          controller: _controllerEmail,
          hintText: "E-mail",
          obscureText: false,
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
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              const Text("Passageiro"),
              Switch(
                  value: _controller.tipoUsuarioPassageiro,
                  onChanged: _controller.stateSaveUser is Loading
                      ? null
                      : (bool valor) {
                          setState(() {
                            _controller.tipoUsuarioPassageiro = valor;
                          });
                        }),
              const Text("Motorista"),
            ],
          ),
        ),
        CustomButton(
          text: "SALVAR",
          color: 0xff1ebbd8,
          loading: _controller.stateSaveUser is Loading,
          onPressed: () {
            _controller.saveUser(
              name: _controllerName.text.trim(),
              lastName: _controllerLastName.text.trim(),
              email: _controllerEmail.text.trim(),
              password: _controllerPassword.text.trim(),
              isPassenger: _controller.tipoUsuarioPassageiro,
            );
          },
          enable: _controller.stateSaveUser is! Loading,
        ),
      ],
    );
  }
}
