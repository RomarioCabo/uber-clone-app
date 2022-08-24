import 'package:flutter/material.dart';

class CustomButtom extends StatefulWidget {
  final String text;
  final int color;
  final Function() onPressed;

  const CustomButtom({
    Key? key,
    required this.text,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CustomButtom> createState() => _CustomButtomState();
}

class _CustomButtomState extends State<CustomButtom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(widget.color),
          padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
        ),
        onPressed: widget.onPressed,
        child: Text(
          widget.text,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
