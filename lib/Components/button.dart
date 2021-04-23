import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  static const OTHER = Color.fromRGBO(226, 89, 0, 1);
  static const DEFAULT = Color.fromRGBO(245, 245, 245, 1);
  static const OPERATION = Color.fromRGBO(92, 214, 70, 1);

  final String text;
  final Color color;
  final bool big;
  final void Function(String) cb;

  Button({
    this.color = DEFAULT,
     this.big = false,
    @required this.text,
    @required this.cb,
  });
  Button.big({
    this.color = DEFAULT,
     this.big = true,
    @required this.text,
    @required this.cb,
  });

  // ignore: empty_constructor_bodies
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: big ? 2 : 1,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          )),
          backgroundColor:
              MaterialStateProperty.all<Color>(Color.fromRGBO(50, 50, 50, 1)),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: this.color,
            fontSize: 32,
            fontWeight: FontWeight.w400,
          ),
        ),
        onPressed: () => cb(text),
      ),
    );
  }
}
