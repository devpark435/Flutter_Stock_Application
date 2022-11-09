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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgColor,
      body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Stock Application",
              ),
            ),
            Padding(
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
                              return showToast('콩쥐야 조때써');
                            }
                          },
                          icon: Icon(Icons.search)),
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
                    // onTap: () {
                    //   Navigator.push(
                    //       context, MaterialPageRoute(builder: (context) => {
                    //         ChartPage(title: 'ComparePage',
                    //                     items: items[searchTextNum],
                    //                     logos: logos[searchTextNum],
                    //                     rates: rates[searchTextNum],
                    //                     prices: price[searchTextNum],)
                    //       }));
                    // },
                  ),
                ),
              ),
              // child: Container(
              //   width: MediaQuery.of(context).size.width * 0.9,
              //   height: 50,
              //   decoration: BoxDecoration(
              //     color: Palette.bgColor,
              //     boxShadow: [
              //       BoxShadow(
              //         blurRadius: 4,
              //         color: Palette.containerShadow,
              //         offset: Offset(0, 2),
              //       )
              //     ],
              //     borderRadius: BorderRadius.circular(25),
              //   ),
              //   alignment: AlignmentDirectional(0, 0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: <Widget>[
              //       Container(
              //         alignment: Alignment.center,
              //         width: 200,
              //         decoration: BoxDecoration(color: Palette.bgColor),
              //         margin: EdgeInsets.all(10),
              //         child: TextField(

              //           onSubmitted: (text) {
              //             setState(() {
              //               searchText = int.parse(text);
              //             });
              //           },
              //         ),
              //       ),
              //       Container(
              //         margin: EdgeInsets.all(10),
              //         child: IconButton(
              //           icon: Icon(Icons.search),
              //           onPressed: () {
              //             Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) => ChartPage(
              //                           title: 'ComparePage',
              //                           items: items[searchText],
              //                           logos: logos[searchText],
              //                           rates: rates[searchText],
              //                           prices: price[searchText],
              //                         )));
              //           },
              //         ),
              //       )
              //     ],
              //   ),
              // ),
            )
          ]),
    );
  }
}

void showToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Color.fromARGB(255, 109, 106, 251),
      textColor: Color.fromARGB(255, 215, 212, 212),
      fontSize: 25.0);
}
