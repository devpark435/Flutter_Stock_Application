import 'dart:ffi';
import 'ChartPage.dart';
import 'ListPage.dart';
import 'package:flutter/material.dart';
import 'package:stock_flutter_app/widgets/customWidget.dart';
import '../asset/palette.dart';
import 'signUpPage.dart';
import 'MyPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  int searchText = 0;
  String inputID = '';
  String inputPW = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                decoration: BoxDecoration(
                    color: Palette.containerColor,
                    borderRadius: BorderRadius.circular(15)),
                child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      onChanged: (text) {
                        setState(() {
                          inputID = text;
                        });
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'ID',
                        hintStyle: TextStyle(
                          color: Palette.bgColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                decoration: BoxDecoration(
                    color: Palette.containerColor,
                    borderRadius: BorderRadius.circular(15)),
                child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      onChanged: (text) {
                        setState(() {
                          inputPW = text;
                        });
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Palette.bgColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Palette.containerColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: GestureDetector(
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: ((context) {
                                return AlertDialog(
                                  title: const Text('LoginData'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: [
                                        Text('ID : ${inputID}'),
                                        Text('PW : ${inputPW}')
                                      ],
                                    ),
                                  ),
                                );
                              }));
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Palette.containerColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: GestureDetector(
                        child: Text(
                          'SignUp',
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
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyPage(title: 'title')));
        },
        backgroundColor: Palette.containerColor,
      ),
    );
  }
}
