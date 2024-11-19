import 'package:flutter/material.dart';



class CalculatorButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;

  const CalculatorButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonColors {
  static const Color equalsButtonColor = Colors.deepPurple;
  static const Color controlButtonColor = Colors.redAccent;
  static const Color operatorButtonColor = Colors.blueAccent;
  static const Color numberButtonColor = Color(0xFFD3D3D3);
  static const Color textColorWhite = Colors.white;
  static const Color textColorBlack = Colors.black;

  static Color getButtonBackgroundColor(String buttonText) {
    switch (buttonText) {
      case '=':
        return equalsButtonColor;
      case 'C':
      case 'D':
        return controlButtonColor;
      case '/':
      case '*':
      case '-':
      case '+':
        return operatorButtonColor;
      default:
        return numberButtonColor;
    }
  }

  static Color getButtonTextColor(String buttonText) {
    switch (buttonText) {
      case '=':
      case 'C':
      case 'D':
      case '/':
      case '*':
      case '-':
      case '+':
        return textColorWhite;
      default:
        return textColorBlack;
    }
  }
}





