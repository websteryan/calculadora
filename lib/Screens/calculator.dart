import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/Components/display.dart';
import 'package:mobile_app/Components/keyboard.dart';
import 'package:mobile_app/Models/memory.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final Memory memory = Memory();

  _onPressed(String com) {
    setState(() {
      memory.applyCommand(com);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      home: Column(
          children: <Widget>[Display(memory.value), Keyboard(_onPressed)]),
    );
  }
}
