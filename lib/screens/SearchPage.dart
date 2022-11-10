import 'dart:ffi';
import 'ChartPage.dart';
import 'ListPage.dart';
import 'package:flutter/material.dart';
import 'package:stock_flutter_app/widgets/customWidget.dart';
import '../asset/palette.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    return Scaffold(
      backgroundColor: Palette.bgColor,
      body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Center(
                child: Text(
                  "Stock Application Logo Area",
                ),
              ),
            ),
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
                                              items: items[searchTextNum],
                                              logos: logos[searchTextNum],
                                              rates: rates[searchTextNum],
                                              prices: price[searchTextNum],
                                            )));
                              } else {
                                return showToast('검색어랑 일치하는 내용이 없습니다.');
                              }
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
                          searchTextNum = items.indexOf(searchText);
                        });
                      },
                    ),
                  ),
                ),
              ),
            )
          ]),
    );
  }
}

void showToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Palette.bgColor,
      textColor: Palette.outlineColor,
      fontSize: 15.0);
}
