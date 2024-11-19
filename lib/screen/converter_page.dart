import 'package:calculator_jongsungkim/screen/home_screen.dart';
import 'package:flutter/material.dart';

import '../button.dart';
import 'calculator_history.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  _ConverterPageState createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  String userInput = "";
  String conversionResult = "";
  String selectedConversion = "Kilometers to Miles";

  void buttonClick(String btnText) {
    setState(() {
      if (btnText == "CONVERT") {
        convert();
      } else if (btnText == "C") {
        userInput = "";
        conversionResult = "";
      } else if (btnText == "D") {
        if (userInput.isNotEmpty) {
          userInput = userInput.substring(0, userInput.length - 1);
        }
      } else {
        userInput += btnText;
      }
    });
  }

  void convert() {
    if (userInput.isEmpty) {
      return;
    }
    try {
      double value = double.parse(userInput);
      double result;
      if (selectedConversion == "Kilometers to Miles") {
        result = value * 0.621371;
      } else {
        result = value / 0.621371;
      }
      conversionResult = result.toStringAsFixed(2);
    } catch (e) {
      conversionResult = "Error";
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> buttons = [
      'C', 'D', 'CONVERT', '',
      '7', '8', '9', '',
      '4', '5', '6', '',
      '1', '2', '3', '',
      '0', '.', '',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kilometer to Miles Converter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CalculatorHistory()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.calculate),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
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
                conversionResult,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Convert: ", style: TextStyle(fontSize: 20)),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedConversion,
                  items: <String>["Kilometers to Miles", "Miles to Kilometers"]
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedConversion = newValue!;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 2.5,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: buttons.length,
              itemBuilder: (context, index) {
                if (buttons[index].isEmpty) {
                  return const SizedBox.shrink();
                }
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
