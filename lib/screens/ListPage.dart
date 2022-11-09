import 'package:flutter/material.dart';
import '../../widgets/customWidget.dart';
import 'package:flutter/material.dart';
import '../asset/palette.dart';
import '../screens/ChartPage.dart';

var items = List<String>.generate(50, (i) => "카카오 $i");
var logos = List<Widget>.generate(
    50, (i) => Image.asset('/Users/ryeol/Desktop/logoKakao.png'));
var rates = List<String>.generate(50, (i) => "Rate $i");
var price = List<String>.generate(50, (i) => "Price $i");
List<Widget> favoriteList = [];

class ListPage extends StatefulWidget {
  const ListPage({super.key, required this.title});
  final String title;

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    //MARK: DefaultTabController
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        //MARK: Custom AppBar
        appBar: AppBar(
          title: Text(
            'Stock Application',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Palette.outlineColor),
          ),
          backgroundColor: Palette.bgColor,
          centerTitle: false,
          elevation: 0,
          //MARK: bottom in tabBar
          bottom: TabBar(
            indicatorColor: Palette.outlineColor,
            isScrollable: true,
            indicatorWeight: 2,
            tabs: <Widget>[
              Tab(
                child: Text(
                  "상장 순위",
                  style: TextStyle(color: Palette.outlineColor),
                ),
              ),
              Tab(
                  child: Text("즐겨찾기",
                      style: TextStyle(color: Palette.outlineColor))),
            ],
          ),
        ),
        backgroundColor: Palette.bgColor,
        body:
            //MARK: TabBarView
            TabBarView(
          children: <Widget>[
            //MARK: Using Class ListContainer
            Tab(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.zero,
                    itemCount: items == null ? 0 : items.length,
                    itemBuilder: (BuildContext context, int index) {
                      var itemDatas = items![index];
                      var logoDatas = logos![index];
                      var rateDatas = rates![index];
                      var priceDatas = price![index];
                      return SizedBox(
                        height: 80,
                        child: Card(
                          elevation: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Palette.bgColor,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Palette.outlineColor,
                                  offset: Offset(
                                    0,
                                    2.0,
                                  ),
                                  blurRadius: 2.0,
                                )
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChartPage(
                                            title: 'ComparePage',
                                            items: itemDatas,
                                            logos: logoDatas,
                                            rates: rateDatas,
                                            prices: priceDatas)));
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: IconButton(
                                      padding: const EdgeInsets.all(0.0),
                                      // splashRadius: 12,
                                      onPressed: () {
                                        //즐겨찾기 추가
                                        setState(() {
                                          var i = 0;
                                          favoriteList.add(Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Palette.bgColor,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Palette.outlineColor,
                                                    offset: Offset(
                                                      0,
                                                      2.0,
                                                    ),
                                                    blurRadius: 2.0,
                                                  )
                                                ],
                                              ),
                                              child: SizedBox(
                                                height: 80,
                                                child: Card(
                                                  shadowColor: Colors.black,
                                                  elevation: 0,
                                                  color: Palette.bgColor,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              favoriteList.remove(
                                                                  favoriteList[
                                                                      i]);
                                                              i++;
                                                            });
                                                          },
                                                          icon: Icon(
                                                              Icons.favorite,
                                                              size: 18,
                                                              color: Palette
                                                                  .outlineColor)),
                                                      Container(
                                                        width: 50,
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            width: 1,
                                                            color: Palette
                                                                .outlineColor,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(items[index]),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Text(price[index]),
                                                          Text(rates[index])
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ));
                                        });
                                      },
                                      icon: Icon(Icons.favorite_border,
                                          size: 18,
                                          color: Palette.outlineColor),
                                    ),
                                  ),
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 1,
                                        color: Palette.outlineColor,
                                      ),
                                    ),
                                  ),
                                  Text(itemDatas),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(priceDatas),
                                      Text(rateDatas)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                // child: ListView(
                //   scrollDirection: Axis.vertical,
                //   padding: EdgeInsets.zero,
                //   children: [
                //     Padding(
                //       padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                //       child: GestureDetector(
                //         child: ListBox(),
                //       ),
                //     ),
                //   ],
                // ),
              ),
            ),

            Tab(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.zero,
                    itemCount: favoriteList == null ? 0 : favoriteList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var i = 0;
                      // if (favoriteList[index] != null) {
                      //   return favoriteList[index];
                      // } else {
                      //   return Center(
                      //     child: Text(
                      //       'There are no favorites yet!',
                      //       style: TextStyle(color: Colors.black),
                      //     ),
                      //   );
                      // }
                      return favoriteList[index];
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
