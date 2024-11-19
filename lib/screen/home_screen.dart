import 'package:calculator_jongsungkim/button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import '../firestore_service.dart';
import '../shared_preferences.dart';
import 'calculator_history.dart';
import 'converter_page.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();

}


class _HomeScreenState extends State<HomeScreen> {

  String userInput = "";
  String answer = "";
  bool isEqualPress = false;
  final FirestoreService _firestoreService = FirestoreService();

  final List<String> buttons = [
    'C', 'D', '%', '/',
    '7', '8', '9', '*',
    '4', '5', '6', '-',
    '1', '2', '3', '+',
    '0', '.', '=',
  ];

  // Showing Results
  void buttonClick(String btnText) {
    setState(() {
      isEqualPress = false;

      switch (btnText) {
        case "=":
          equalPressedOperation();
          break;
        case "C":
          userInput = "";
          answer = "";
          break;
        case "D":
          if (userInput.isNotEmpty) {
            userInput = userInput.substring(0, userInput.length - 1);
          }
          break;
        default:
          userInput += btnText;
          break;
      }
    });
  }

  void equalPressedOperation() {

    if (userInput.isEmpty) {
      return;
    }
    try {
      Parser p = Parser();
      Expression exp = p.parse(userInput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      answer = eval.toString();
      isEqualPress = true;

      //saveToHistory();
      _firestoreService.saveCalculation(userInput, answer);
    } catch (e) {
      answer = "Error";
    }
  }

  void saveToHistory() {
    SimplePreferences.addToCalculationHistory(userInput, answer);
  }


  // Main App
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator with History and Converter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalculatorHistory()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConverterPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: Text(
                userInput,
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: Text(
                answer,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: buttons.length,
              itemBuilder: (context, index) {
                return CalculatorButton(
                  buttonText: buttons[index],
                  onTap: () => buttonClick(buttons[index]),
                  backgroundColor: ButtonColors.getButtonBackgroundColor(buttons[index]),
                  textColor: ButtonColors.getButtonTextColor(buttons[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}
