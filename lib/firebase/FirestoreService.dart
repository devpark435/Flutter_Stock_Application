import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreService extends ChangeNotifier {
  final userCollection = FirebaseFirestore.instance.collection('user');
  Future<QuerySnapshot> read(String uid) async {
    return userCollection.where('uid', isEqualTo: uid).get();
  }

  void create(String uid) async {
    await userCollection.doc(uid).set({
      'uid': uid,
      'money': 10000000,
    });
  }

  void update(String uid, int money) async {
    notifyListeners(); // 화면 갱신
  }

  void delete(String docId) async {
    // 삭제
  }
}
