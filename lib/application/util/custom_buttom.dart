import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomButtom extends StatefulWidget {
  final String text;
  final int color;
  final bool loading;
  final Function() onPressed;
  final bool enable;

  const CustomButtom({
    Key? key,
    required this.text,
    required this.color,
    required this.loading,
    required this.onPressed,
    required this.enable,
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
        onPressed: widget.enable ? widget.onPressed : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            widget.loading
                ? Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: const SpinKitDualRing(
                      color: Colors.white,
                      size: 16,
                      lineWidth: 3,
                    ),
                  )
                : Container(),
            Center(
              child: Text(
                widget.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
