import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveCalculation(String calculation, String result) async {
    try {
      await _db.collection('calculations').add({
        'calculation': calculation,
        'result': result,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print("Calculation saved successfully.");
    } catch (e) {
      print("Error saving calculation: $e");
    }
  }

  Future<List<String>> getCalculationHistory() async {
    QuerySnapshot snapshot = await _db.collection('calculations').orderBy('timestamp', descending: true).get();
    return snapshot.docs.map((doc) => '${doc['calculation']} = ${doc['result']}').toList();
  }

  Future<void> clearCalculationHistory() async {
    QuerySnapshot snapshot = await _db.collection('calculations').get();
    for (DocumentSnapshot doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}