import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../util/custom_button.dart';

class NoContent extends StatefulWidget {
  final String imagePath;
  final String alertText;
  final String buttonText;
  final Function() function;

  const NoContent({
    Key? key,
    required this.imagePath,
    required this.alertText,
    required this.buttonText,
    required this.function,
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
                widget.imagePath,
                width: 200,
                height: 150,
              ),
              Container(
                height: 14.0,
              ),
              Text(
                widget.alertText,
                style: const TextStyle(
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
                  text: widget.buttonText,
                  color: 0xff37474f,
                  loading: false,
                  onPressed: widget.function,
                  enable: true,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
