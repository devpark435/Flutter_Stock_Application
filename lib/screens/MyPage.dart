import 'dart:ffi';
import 'ChartPage.dart';
import 'ListPage.dart';
import 'package:flutter/material.dart';
import 'package:stock_flutter_app/widgets/customWidget.dart';
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
    return Scaffold();
  }
}
