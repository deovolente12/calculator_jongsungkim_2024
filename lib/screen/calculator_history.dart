import 'package:flutter/material.dart';

//import 'package:calculator_jongsungkim/shared_preferences.dart';
import '../firestore_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home_screen.dart';
import 'converter_page.dart';

class CalculatorHistory extends StatefulWidget {
  const CalculatorHistory({super.key});

  @override
  State<CalculatorHistory> createState() => _CalculatorHistoryState();
}

class _CalculatorHistoryState extends State<CalculatorHistory> {
  List<String> history = [];
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    initializeFirebaseAndLoadHistory();
  }

  Future<void> initializeFirebaseAndLoadHistory() async {
    await Firebase.initializeApp(); // Ensure Firebase is initialized
    loadHistory();
  }

  void loadHistory() async {
    List<String> savedHistory = await _firestoreService.getCalculationHistory();
    if (savedHistory != null) {
      setState(() {
        history = savedHistory;
      });
    }
  }

  void clearHistory() {
    setState(() {
      history.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calculate),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              height: 200,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
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
              child: history.isNotEmpty
                  ? ListView.builder(
                      itemCount: history.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            history[index],
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        'No history available',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: clearHistory,
              child: const Text('Clear History'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
