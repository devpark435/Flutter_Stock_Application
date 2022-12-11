import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'ChartPage.dart';
import 'ListPage.dart';
import 'package:flutter/material.dart';
import '../asset/palette.dart';
import 'signUpPage.dart';
import '../firebase/FirestoreService.dart';
import '../firebase/auth_service.dart';
import 'package:firebase_database/firebase_database.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key, required this.title});
  final String title;
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('log');
  String eMail = '';

  int currentMoney = 0;
  FirestoreService fs = new FirestoreService();
  FirestoreService logfs = new FirestoreService();

  Future<void> setWallet(String uid) async {
    final snapshot = await fs.userCollection.where('uid', isEqualTo: uid).get();

    final documents = snapshot.docs;
    int index = 0;
    final doc = documents[index];
    int walletMoney = doc.get('money');
    currentMoney = walletMoney;

    print(walletMoney);
  }

  // Future<void> getModel(String uid) async {
  //   CollectionReference<Map<String, dynamic>> colReference =
  //       FirebaseFirestore.instance.collection(uid);
  //   QuerySnapshot<Map<String, dynamic>> colSnap = await colReference.get();

  // }
  Future<void> getModel(String uid) async {
    var snapshot =
        await FirebaseFirestore.instance.collection('log').doc(eMail).get();

    var snapshotData = snapshot.data()!;
    LinkedHashMap<String, dynamic> data = snapshot['939701'];

    List<dynamic> values = data.values.toList();
    for (var i = 0; i < snapshotData.length; i++) {
      final Map<String, dynamic> map = snapshotData.values.elementAt(i);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final currentUser = auth.currentUser;
    eMail = currentUser!.email.toString();
    currentMoney;
    setWallet(eMail);
    getModel(eMail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'My Page',
                  style: Styles.headerText,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              alignment: Alignment.center,
              height: 150,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Palette.moneyColor),
              child: Column(
                children: [
                  Text('E-mail: ${eMail}'),
                  Text('uid: '),
                  Text('Wallet: ${currentMoney}'),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.download),
              onPressed: () {
                setState(() {
                  setWallet(eMail);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
