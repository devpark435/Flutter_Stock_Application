import 'dart:ffi';
import 'ChartPage.dart';
import 'ListPage.dart';
import 'package:flutter/material.dart';
import 'package:stock_flutter_app/widgets/customWidget.dart';
import '../asset/palette.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.title});
  final String title;
  @override
  State<SearchPage> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  int searchText = 0;
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
              width: MediaQuery.of(context).size.width,
              height: 80,
              decoration: BoxDecoration(
                color: Palette.bgColor,
              ),
              child: Text(
                "Stock Application",
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                decoration: BoxDecoration(
                  color: Palette.bgColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Palette.containerShadow,
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(25),
                ),
                alignment: AlignmentDirectional(0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: 200,
                      decoration: BoxDecoration(color: Palette.bgColor),
                      margin: EdgeInsets.all(10),
                      child: TextField(
                        onSubmitted: (text) {
                          setState(() {
                            searchText = int.parse(text);
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChartPage(
                                        title: 'ComparePage',
                                        items: items[searchText],
                                        logos: logos[searchText],
                                        rates: rates[searchText],
                                        prices: price[searchText],
                                      )));
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ]),
    );
  }
}
