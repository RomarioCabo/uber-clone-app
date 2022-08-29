import 'package:flutter/material.dart';

showAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
  required Function() function,
}) {
  Widget closeButton = TextButton(
    child: const Text("FECHAR"),
    onPressed: () {
     Navigator.pop(context);
    },
  );
  Widget cancelButton = TextButton(
    onPressed: function,
    child: const Text("CONFIRMAR"),
  );
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      closeButton,
      cancelButton,
    ],
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
