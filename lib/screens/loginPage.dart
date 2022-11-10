import 'dart:ffi';
import 'package:provider/provider.dart';

import '../login/auth_service.dart';
import '../main.dart';
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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
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
                          controller: emailController,
                          onChanged: (text) {
                            setState(() {
                              inputID = text;
                            });
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'E-Mail',
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
                          controller: passwordController,
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
                          child: ElevatedButton(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              // 로그인
                              authService.signIn(
                                email: emailController.text,
                                password: passwordController.text,
                                onSuccess: () {
                                  // 로그인 성공
                                  /* ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("로그인 성공"),
                                  )); */

                                  // HomePage로 이동
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MarketPage()),
                                  );
                                  showDialog(
                                      context: context,
                                      builder: ((context) {
                                        return AlertDialog(
                                          title: const Text('LoginData'),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: [
                                                Text('로그인성공'),
                                                Text('E-Mail : ${inputID}'),
                                                Text('PW : ${inputPW}')
                                              ],
                                            ),
                                          ),
                                        );
                                      }));
                                },
                                onError: (err) {
                                  // 에러 발생
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(err),
                                  ));
                                },
                              );
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyPage(title: 'title')));
            },
            backgroundColor: Palette.containerColor,
          ),
        );
      },
    );
  }
}
