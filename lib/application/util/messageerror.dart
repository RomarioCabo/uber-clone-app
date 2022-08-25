import 'package:flutter/material.dart';

class MessageError extends StatefulWidget {
  final String messageError;

  const MessageError({Key? key, required this.messageError}) : super(key: key);

  @override
  State<MessageError> createState() => _MessageErrorState();
}

class _MessageErrorState extends State<MessageError> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Center(
        child: Text(
          widget.messageError,
          style: const TextStyle(color: Colors.red, fontSize: 20),
        ),
      ),
    );
  }
}
