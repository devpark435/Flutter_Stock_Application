import 'package:provider/provider.dart';
import 'package:stock_flutter_app/screens/loginPage.dart';

import '../firebase/auth_service.dart';
import 'ChartPage.dart';
import 'ListPage.dart';
import 'package:flutter/material.dart';

import '../asset/palette.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Stock_List.dart';
import 'package:cp949/cp949.dart' as cp949;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.title});
  final String title;
  @override
  State<SearchPage> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  String searchText = '';
  int searchTextNum = 0;
  final _nameInputcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(builder: (context, authService, child) {
      return Scaffold(
        backgroundColor: Palette.bgColor,
        body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width *
                      0.9, //authService.currentUser()
                  child: authService.currentUser() == null
                      ? Center(
                          child: Column(
                            children: [
                              Text(
                                "InvestGame",
                                style: Styles.mainHeaderText,
                              ),
                              Text(
                                "Application",
                                style: Styles.mainHeaderText2,
                              ),
                              GestureDetector(
                                child: Text(
                                  '로그인이 필요합니다',
                                  style: Styles.subText,
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              LoginPage(title: 'title'))));
                                },
                              )
                            ],
                          ),
                        )
                      : Center(
                          child: Column(
                            children: [
                              Text(
                                "InvestGame",
                                style: Styles.mainHeaderText,
                              ),
                              Text(
                                "Application",
                                style: Styles.mainHeaderText2,
                              ),
                            ],
                          ),
                        )),
              Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Palette.bgColor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 1,
                        color: Palette.outlineColor,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _nameInputcontroller,
                        obscureText: false,
                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                              onPressed: () {
                                //검색어 null값 Handler
                                if (searchTextNum != -1) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChartPage(
                                                title: 'ComparePage',
                                                items: cp949.decodeString(
                                                    stockName![searchTextNum]),
                                                logos: logos[searchTextNum],
                                                rates: stockRateScrap[
                                                    searchTextNum],
                                                prices:
                                                    dayPriceList[searchTextNum],
                                              )));
                                  return showToast('${searchTextNum}');
                                } else {
                                  return showToast('검색어랑 일치하는 내용이 없습니다.');
                                }
                                // return showToast('${searchTextNum}');
                              },
                              icon: Icon(Icons.search)),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              _nameInputcontroller.clear();
                            },
                          ), //검색어 remove button
                          hintText: 'Search',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                              color: Palette.bgColor,
                            ),
                          ),
                        ),
                        onSubmitted: (text) {
                          setState(() {
                            searchText = text;
                            if (stockName!.indexOf(
                                    cp949.encodeToString(searchText)) ==
                                null) {
                              searchTextNum = -1;
                            } else {
                              searchTextNum = stockName!
                                  .indexOf(cp949.encodeToString(searchText));
                              print(searchTextNum);
                            } //, attributes:  null}}, {title:
                          });
                        },
                      ),
                    ),
                  ),
                ),
              )
            ]),
      );
    });
  }
}

void showToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Palette.bgColor,
      textColor: Palette.outlineColor,
      fontSize: 15.0);
}
