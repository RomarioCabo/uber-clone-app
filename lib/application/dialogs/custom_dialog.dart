import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  final String text;

  const CustomDialog({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text);
  }
}
