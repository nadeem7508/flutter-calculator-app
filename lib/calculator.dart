
import 'package:flutter/material.dart';
class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _input = '';
  String _result = '';
//button code 
  void _buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _input = '';
        _result = '';
      } else if (value == '=') {
        try {
          _result = _evaluate(_input);
        } catch (e) {
          _result = 'Error';
        }
      } else {
        _input += value;
      }
    });
  }

  String _evaluate(String input) {
    try {
      final expression = input.replaceAll('×', '*').replaceAll('÷', '/');
      final result = _calculateExpression(expression);
      return result.toString();
    } catch (e) {
      return 'Error';
    }
  }
//calculations
  double _calculateExpression(String expression) {
    final tokens = RegExp(r'(\d+\.?\d*|\+|\-|\*|/)')
        .allMatches(expression)
        .map((e) => e.group(0)!)
        .toList();

    double result = double.parse(tokens[0]);
    for (int i = 1; i < tokens.length; i += 2) {
      String op = tokens[i];
      double num = double.parse(tokens[i + 1]);

      if (op == '+') result += num;
      if (op == '-') result -= num;
      if (op == '*') result *= num;
      if (op == '/') result /= num;
    }
    return result;
  }

  Widget _buildButton(String text, {Color color = Colors.white}) {
    return ElevatedButton(
      onPressed: () => _buttonPressed(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: color,
        padding: EdgeInsets.all(24),
        shape: CircleBorder(),
      ),
      child: Text(text, style: TextStyle(fontSize: 24)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttons = [
      ['7', '8', '9', '÷'],
      ['4', '5', '6', '×'],
      ['1', '2', '3', '-'],
      ['0', '.', '=', '+'],
      ['C']
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Devnity Solutions ')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(_input, style: TextStyle(fontSize: 32)),
          ),
          Container(
            padding: EdgeInsets.only(right: 20),
            alignment: Alignment.centerRight,
            child: Text(_result, style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 10),
          ...buttons.map((row) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: row.map((btn) {
                return _buildButton(
                  btn,
                  color: ['÷', '×', '-', '+', '='].contains(btn) ? Colors.orange : Colors.white,
                );
              }).toList(),
            );
          }).toList(),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}