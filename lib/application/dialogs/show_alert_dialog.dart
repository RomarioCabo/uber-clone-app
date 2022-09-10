import 'package:flutter/material.dart';

import 'custom_dialog.dart';
import 'custom_loading_dialog.dart';

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
    content: CustomDialog(
      text: content,
    ),
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

showLoadingDialog({
  required BuildContext context,
  required String? title,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return CustomLoadingDialog(title: title);
    },
  );
}
