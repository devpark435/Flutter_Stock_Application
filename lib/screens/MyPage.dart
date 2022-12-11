import 'ChartPage.dart';
import 'ListPage.dart';
import 'package:flutter/material.dart';

import '../asset/palette.dart';
import 'signUpPage.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key, required this.title});
  final String title;
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
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
                children: [Text('ID'), Text('E-mail'), Text('Wallet')],
              ),
            )
          ],
        ),
      ),
    );
  }
}
