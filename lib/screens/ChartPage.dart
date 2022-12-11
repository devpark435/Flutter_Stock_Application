import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_flutter_app/firebase/FirestoreService.dart';
import 'package:stock_flutter_app/screens/ListPage.dart';
import 'package:stock_flutter_app/screens/loginPage.dart';
import 'package:stock_flutter_app/screens/newsPage.dart';
import 'package:stock_flutter_app/screens/SignupPage.dart';
import '../asset/palette.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../firebase/FirestoreService.dart';
import '../firebase/auth_service.dart';
import 'SignupPage.dart';
import 'Chart.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({
    super.key,
    required this.title,
    required this.items,
    required this.logos,
    required this.rates,
    required this.prices,
  });
  final String title;
  final String items;
  final Widget logos;
  final String rates;
  final String prices; //현재가 받아온 변수
  @override
  State<ChartPage> createState() => _ChartPage();
}

class _ChartPage extends State<ChartPage> {
  FirestoreService fs = new FirestoreService();
  final auth = FirebaseAuth.instance;
  int Buying = 0;
  int wallet = 0;
  String selling = ' ';
  int userMoney = 0;

  get index => null;

  Future<void> buyItem(int buyPrice, String uid) async {
    final fs = FirestoreService();
    final snapshot = await fs.userCollection.where('uid', isEqualTo: uid).get();
    final documents = snapshot.docs;
    int index = 0;
    final doc = documents[index];
    int currentMoney = doc.get('money');
    fs.userCollection.doc(uid).update({'money': currentMoney - buyPrice});
  }

  Future<void> sellItem(int sellPrice, String uid) async {
    final fs = FirestoreService();
    final snapshot = await fs.userCollection.where('uid', isEqualTo: uid).get();
    final documents = snapshot.docs;
    int index = 0;
    final doc = documents[index];
    int currentMoney = doc.get('money');
    fs.userCollection.doc(uid).update({'money': currentMoney + sellPrice});
  }

  @override
  Widget build(BuildContext context) {
    List<_SalesData> data = [
      _SalesData('3', 5000),
      _SalesData('2', 5200),
      _SalesData('1', 5300),
      _SalesData('0', 5400)
    ];
    return Consumer<AuthService>(builder: (context, authService, child) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Palette.bgColor,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Palette.containerShadow),
            backgroundColor: Palette.appbarColor,
            centerTitle: false,
            elevation: 0,
            actions: [
              new IconButton(
                icon: new Icon(Icons.newspaper),
                tooltip: 'NewsScrap',
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewsPage(
                                title: 'title',
                                itemName: widget.items,
                              )))
                },
              )
            ],
            title: Text(widget.items),
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              Container(
                // ItmeNameContainer
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                width: MediaQuery.of(context).size.width * 0.9,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    widget.logos,
                    Text(widget.items),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.prices,
                              style: TextStyle(
                                  color: widget.rates.indexOf('-') > 0
                                      ? Palette.moneyColor
                                      : Palette.moneyOffColor),
                            ),
                          ],
                        ),
                        Text(
                          widget.rates,
                          style: TextStyle(
                              color: widget.rates.indexOf('-') > 0
                                  ? Palette.moneyColor
                                  : Palette.moneyOffColor),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [chartArea(widget.items), chartArea(widget.items)],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.1,
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
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.1,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("InvestmentGame"),
                          IconButton(
                            icon: const Icon(Icons.attach_money),
                            color: Palette.moneyColor,
                            onPressed: () {
                              if (authService.currentUser() != null) {
                                showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        alignment: Alignment.center,
                                        title: Text("매수"),
                                        actions: <Widget>[
                                          //
                                          TextButton(
                                              onPressed: () {

                                                setState(() {
                                                  int buyPrice = (Buying *
                                                      int.parse(widget.prices
                                                          .replaceAll(
                                                              ',', '')));
                                                  final currentUser =
                                                      auth.currentUser;
                                                  if (currentUser != null) {
                                                    String uid = currentUser
                                                        .email
                                                        .toString();
                                                    buyItem(buyPrice, uid);
                                                  }
                                                });

                                                Navigator.pop(context);
                                              }, //매도 확인 버튼 이벤트
                                              child: Text('매수 확인'))
                                        ],
                                        backgroundColor: Palette.bgColor,
                                        content: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextField(
                                                onTap: () {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                },
                                                onChanged: (text) {
                                                  setState(() {
                                                    Buying = int.parse(text);
                                                  });
                                                },
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: '몇 주를 매수하시겠습니까?',
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                              Column(
                                                children: [
                                                  Text('${Buying}' +
                                                      "주를 매수합니다."),
                                                  Text(
                                                      '매수 금액은 ${Buying * int.parse(widget.prices.replaceAll(',', ''))}입니다.'),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage(
                                              title: '',
                                            )));
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.money_off_csred),
                            color: Palette.moneyOffColor,
                            onPressed: () {
                              if (authService.currentUser() != null) {
                                showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        alignment: Alignment.center,
                                        title: Text("매도"),
                                        backgroundColor: Palette.bgColor,
                                        actions: <Widget>[
                                          TextButton(
                                              onPressed: () {
                                                Future.delayed(
                                                    Duration(milliseconds: 500),
                                                    () {
                                                  int sellPrice =
                                                      (int.parse(selling) *
                                                          int.parse(widget
                                                              .prices
                                                              .replaceAll(
                                                                  ',', '')));
                                                  final currentUser =
                                                      auth.currentUser;
                                                  if (currentUser != null) {
                                                    String uid = currentUser
                                                        .email
                                                        .toString();
                                                    sellItem(sellPrice, uid);
                                                  }
                                                  setState(() {});
                                                  Navigator.pop(context);
                                                });
                                              },
                                              child: Text('매도 확인'))
                                        ],
                                        content: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextField(
                                                onTap: () {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                },
                                                onChanged: (text) {
                                                  setState(() {
                                                    selling = text;
                                                  });
                                                },
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: '몇 주를 매도하시겠습니까?',
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                              Text(selling + "주를 매도합니다."),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage(
                                              title: '',
                                            )));
                              }
                            },
                          )
                        ],
                      ))
                ],
              ),
            ]),
          ));
    });
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final int sales;
}
