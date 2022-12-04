import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabase {
  final userCollection = FirebaseFirestore.instance.collection('user');
  final int money = 10000000;

  void createUser(String uid) {
    userCollection.add({'uid': uid, 'money': money});
  }
}
