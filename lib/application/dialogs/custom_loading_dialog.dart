import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoadingDialog extends StatefulWidget {
  final String? title;

  const CustomLoadingDialog({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<CustomLoadingDialog> createState() => _CustomLoadingDialogState();
}

class _CustomLoadingDialogState extends State<CustomLoadingDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        margin: const EdgeInsets.fromLTRB(120.0, 320.0, 120.0, 320.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0),
              child: Text(
                widget.title!,
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 26.0),
              child: const SpinKitDualRing(
                color: Colors.blue,
                size: 24,
                lineWidth: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
