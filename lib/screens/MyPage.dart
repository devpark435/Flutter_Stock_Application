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
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Text('My Page'),
            SizedBox(
              height: 25,
            )
          ],
        ),
      )),
    );
  }
}
