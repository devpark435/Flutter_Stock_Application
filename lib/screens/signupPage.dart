import 'dart:ffi';
import 'package:provider/provider.dart';
import 'package:stock_flutter_app/screens/loginPage.dart';

import '../login/auth_service.dart';
import 'ChartPage.dart';
import 'ListPage.dart';
import 'package:flutter/material.dart';
import 'package:stock_flutter_app/widgets/customWidget.dart';
import '../asset/palette.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key, required this.title});
  final String title;
  @override
  State<SignupPage> createState() => _SignupPage();
}

class _SignupPage extends State<SignupPage> {
  int searchText = 0;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String signID = ''; //sign up id 변수
  String signPW = ''; //sign up password 변수
/*   String checkPW = ''; //sign up check password 변수 */
  String signEM = ''; //sign up email 변수
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        return Scaffold(
          backgroundColor: Palette.bgColor,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                //sign up id input container
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
                            signID = text;
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
                //sign up PW input container
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
                            signPW = text;
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
              /* Padding(
                //check PW input container
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
                            checkPW = text;
                          });
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Check Password',
                          hintStyle: TextStyle(
                            color: Palette.bgColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ), */
/*           Padding(
                //sign up E-mail input container
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
                            signEM = text;
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
              ), */
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
                            'SignUp',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            authService.signUp(
                              email: emailController.text,
                              password: passwordController.text,
                              onSuccess: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage(
                                            title: '',
                                          )),
                                );

                                showDialog(
                                    context: context,
                                    builder: ((context) {
                                      return AlertDialog(
                                        title: const Text('환영합니다'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: [
                                              Text('회원가입성공'),
                                            ],
                                          ),
                                        ),
                                      );
                                    }));
                                // 회원가입 성공
                                /* ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("회원가입 성공"),
                                )); */
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
                            'kakao',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
