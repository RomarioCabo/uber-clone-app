import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../domain/store/routes_driver/route_uber_controller_impl.dart';
import '../../infrastructure/helpers/request_state.dart';
import '../util/custom_button.dart';

class NoContent extends StatefulWidget {
  final RouteUberControllerImpl controller;

  const NoContent({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<NoContent> createState() => _NoContentState();
}

class _NoContentState extends State<NoContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Observer(
        builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Ooops!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36.0,
                ),
              ),
              Image.asset(
                "imagens/no_results_found.png",
                width: 200,
                height: 150,
              ),
              Container(
                height: 14.0,
              ),
              const Text(
                "Não encontramos nenhuma corrida disponível",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                ),
              ),
              Container(
                height: 18.0,
              ),
              Container(
                margin: const EdgeInsets.only(left: 60.0, right: 60.0),
                child: CustomButton(
                  text: "VERIFICAR NOVAMENTE",
                  color: 0xff37474f,
                  loading: widget.controller.requestStateTryAgain is Loading,
                  onPressed: () {
                    widget.controller.tryAgain();
                  },
                  enable: widget.controller.requestStateTryAgain is! Loading,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
