import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:stock_flutter_app/screens/loginPage.dart';
import 'ChartPage.dart';
import 'ListPage.dart';
import 'package:flutter/material.dart';
import '../asset/palette.dart';
import 'signUpPage.dart';
import '../firebase/FirestoreService.dart';
import '../firebase/auth_service.dart';
import 'package:firebase_database/firebase_database.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

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
  int logCount = 0;

  List<String> keyList = [];
  List<String> keyListSort = [];
  List<String> walValue = [];

  Future<void> setWallet(String uid) async {
    final snapshot = await fs.userCollection.where('uid', isEqualTo: uid).get();
    final walLog = await logfs.logCollection.doc(uid).get();
    final documents = snapshot.docs;
    walValue.clear();
    int index = 0;
    final doc = documents[index];
    int walletMoney = doc.get('money');
    currentMoney = walletMoney;
    print(walLog.data()!.length);
    print(walletMoney);

    var keys = walLog.data()!.keys;
    logCount = keys.length;
    keys.forEach((element) {
      if (element != 'uid') {
        print(element);
        keyList.add(element);
      }
    });

    final logSnapshot =
        await fs.logCollection.where('uid', isEqualTo: uid).get();
    final logDocuments = logSnapshot.docs;
    final logDocs = logDocuments[index];

    print('key$keys');
    print(logDocs.data().values);
    logDocs.data().values.forEach(
      (element) {
        if (element != '123@123.123') {
          walValue.add(element.toString().substring(8).replaceAll('}', ''));
        }
      },
    );

    print(keyList);
    print(walValue.length);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final currentUser = auth.currentUser;
    eMail = currentUser!.email.toString();
    setWallet(eMail);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(builder: (context, authService, child) {
      if (authService.currentUser() != null) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My Page',
                          style: Styles.mainHeaderText,
                        ),
                        IconButton(
                          icon: Icon(Icons.refresh_sharp),
                          onPressed: () {
                            setState(() {
                              setWallet(eMail);
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                // Container(
                //   alignment: Alignment.center,
                //   height: 150,
                //   width: MediaQuery.of(context).size.width * 0.9,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(15),
                //     color: Palette.bgColor,
                //     border: Border.all(
                //       width: 2,
                //       color: Palette.moneyColor,
                //     ),
                //   ),
                //   child: Column(
                //     children: [
                //       Text(
                //         'ID : ${eMail}',
                //         style: Styles.emText,
                //       ),
                //       Text(
                //         '자금: ${currentMoney}원',
                //         style: Styles.emText,
                //       ),
                //     ],
                //   ),
                // ),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150),
                    border: Border.all(
                      width: 2,
                      color: Palette.moneyColor,
                    ),
                  ),
                  child: Icon(
                    Icons.person,
                    size: 100,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(children: [
                    Text(
                      '$eMail',
                      style: Styles.emText,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          child: Text(
                            '자금 :',
                            style: Styles.emText,
                          ),
                        ),
                        Container(
                          child: Text(
                            '${currentMoney} 원',
                            style: Styles.emText,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          child: Text(
                            '수익률 :',
                            style: Styles.emText,
                          ),
                        ),
                        Container(
                          child: Text(
                            '${(currentMoney - 10000000) / 10000000} %',
                            style: Styles.emText,
                          ),
                        ),
                      ],
                    )
                  ]),
                ),
                SizedBox(
                  height: 25,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    width: 400,
                    height: 320,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount:
                            walValue.length == null ? 0 : walValue.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.center,
                              width: 400,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Palette.bgColor,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: Palette.outlineColor,
                                    offset: Offset(0, 5),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '거래 일자',
                                    style: Styles.emText,
                                  ),
                                  Text('${keyList[index]}'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '거래 내용',
                                    style: Styles.emText,
                                  ),
                                  Text('${walValue[index]}'),
                                ],
                              ),
                            ),
                          );
                        })),
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => stockList()));
              authService.signOut();
            },
            backgroundColor: Palette.outlineColor,
            child: Icon(Icons.outbond),
          ),
        );
      } else if (authService.currentUser() == null) {
        return Scaffold(
          body: Center(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '로그인 또는 회원가입',
                      style: Styles.headerText,
                    ),
                    Text(
                      '후에 이용할 수 있습니다',
                      style: Styles.headerText,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Palette.outlineColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: GestureDetector(
                          child: Text(
                            '로그인',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LoginPage(title: 'title')));
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Palette.outlineColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: GestureDetector(
                          child: Text(
                            '회원가입',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SignupPage(title: 'title')));
                          },
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        );
      } else {
        return Text('ERROR!');
      }
    });
  }
}


// class MyPage extends StatefulWidget {
//   const MyPage({super.key, required this.title});
//   final String title;
//   @override
//   State<MyPage> createState() => _MyPageState();
// }

// class _MyPageState extends State<MyPage> {
//   final auth = FirebaseAuth.instance;
//   final ref = FirebaseDatabase.instance.ref('log');
//   String eMail = '';
//   List<String> walletLog = [];
//   int currentMoney = 0;
//   FirestoreService fs = new FirestoreService();
//   FirestoreService logfs = new FirestoreService();
//   int logCount = 0;

//   Future<void> setWallet(String uid) async {
//     final snapshot = await fs.userCollection.where('uid', isEqualTo: uid).get();
//     final walLog = await logfs.logCollection.doc(uid).get();
//     final documents = snapshot.docs;
//     Iterable logvalue = walLog.data()!.values;
//     int index = 0;
//     final doc = documents[index];
//     int walletMoney = doc.get('money');
//     currentMoney = walletMoney;
//     print(walLog.data()!.length);
//     print(walletMoney);
//     print(logvalue.length);
//     logCount = logvalue.length;
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     final currentUser = auth.currentUser;
//     eMail = currentUser!.email.toString();
//     currentMoney;
//     setWallet(eMail);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               width: double.infinity,
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Text(
//                   'My Page',
//                   style: Styles.headerText,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 25,
//             ),
//             Container(
//               alignment: Alignment.center,
//               height: 150,
//               width: MediaQuery.of(context).size.width * 0.9,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: Palette.moneyColor),
//               child: Column(
//                 children: [
//                   Text('E-mail: '),
//                   Text('uid: '),
//                   Text('Wallet: '),
//                 ],
//               ),
//             ),
//             IconButton(
//               icon: Icon(Icons.download),
//               onPressed: () {
//                 setState(() {
//                   setWallet(eMail);
//                 });
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
