import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CounterService {
  static Stream<int> counterValue() {
    return FirebaseFirestore.instance
        .collection('counter')
        .doc('main-counter')
        .snapshots()
        .map((event) {
      return event.data()!['counterValue'];
    });
  }

  static incrementCounter(int counterValue) {
    return FirebaseFirestore.instance
        .collection('counter')
        .doc('main-counter')
        .update({'counterValue': counterValue});
  }
}
