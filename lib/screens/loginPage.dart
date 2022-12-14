import '../main.dart';
import 'ChartPage.dart';
import 'ListPage.dart';
import 'package:flutter/material.dart';

import '../asset/palette.dart';
import 'signUpPage.dart';
import 'MyPage.dart';
import '../firebase/auth_service.dart';
import 'package:provider/provider.dart';

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
  TextEditingController emailController =
      TextEditingController(); //E-mail Controller
  TextEditingController passwordController =
      TextEditingController(); //Password Controller
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(builder: (context, authService, child) {
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
                      color: Palette.outlineColor,
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
                          hintText: 'E-mail',
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
                      color: Palette.outlineColor,
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
                            color: Palette.outlineColor,
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
                            // showDialog(
                            //     context: context,
                            //     builder: ((context) {
                            //       return AlertDialog(
                            //         title: const Text('LoginData'),
                            //         content: SingleChildScrollView(
                            //           child: ListBody(
                            //             children: [
                            //               Text('ID : ${inputID}'),
                            //               Text('PW : ${inputPW}')
                            //             ],
                            //           ),
                            //         ),
                            //       );
                            //     }));
                            // ?????????
                            authService.signIn(
                              email: emailController.text,
                              password: passwordController.text,
                              onSuccess: () {
                                // ????????? ??????
                                /* ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text("????????? ??????"),
                                      )); */

                                // HomePage??? ??????
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
                                              Text('???????????????'),
                                              Text('E-Mail : ${inputID}'),
                                              Text('PW : ${inputPW}')
                                            ],
                                          ),
                                        ),
                                      );
                                    }));
                              },
                              onError: (err) {
                                // ?????? ??????
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
                            color: Palette.outlineColor,
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
                context, MaterialPageRoute(builder: (context) => MyPage()));
          },
          backgroundColor: Palette.outlineColor,
          child: Icon(Icons.people),
        ),
      );
    });
  }
}
