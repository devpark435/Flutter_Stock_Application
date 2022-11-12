import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';
import '../../widgets/customWidget.dart';
import 'package:flutter/material.dart';
import '../asset/palette.dart';
import '../screens/ChartPage.dart';
import 'package:cp949/cp949.dart' as cp949;

var items = List<String>.generate(50, (i) => "카카오 $i");
var logos = List<Widget>.generate(
  50,
  (i) => Container(
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
);
var rates = List<String>.generate(50, (i) => "Rate $i");
var price = List<String>.generate(50, (i) => "Price $i");
List<Widget> favoriteList = [];
List<String>? stockName;
late List<String> stockRateScrap;
late List<String> stockAgoRateScrap;

class ListPage extends StatefulWidget {
  const ListPage({super.key, required this.title});
  final String title;

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  // initialize WebScraper by passing base url of website
  final webScraper = WebScraper('https://finance.naver.com/');
  // Response of getElement is always List<Map<String, dynamic>>

  void fetchProducts() async {
    // Loads web page and downloads into local state of library
    if (await webScraper.loadWebPage('sise/sise_market_sum.naver')) {
      setState(() {
        // getElement takes the address of html tag/element and attributes you want to scrap from website
        // it will return the attributes in the same order passed
        stockName = webScraper.getElementTitle(
          //주식명 scrap
          // document.querySelector("#contentarea > div.box_type_l > table.type_2 > tbody > tr:nth-child(2) > td:nth-child(2) > a")
          'div.box_type_l > table.type_2 > tbody > tr > td > a',
        );
        stockRateScrap = webScraper.getElementTitle(
          //등락률 scrap
          //document.querySelector("#contentarea > div.box_type_l > table.type_2 > tbody > tr:nth-child(2) > td:nth-child(5) > span")
          //
          'div.box_type_l > table.type_2 > tbody > tr > td > span.tah.p11.red01',
        );
        stockAgoRateScrap = webScraper.getElementTitle(
          //전일대비 scrap
          //document.querySelector("#contentarea > div.box_type_l > table.type_2 > tbody > tr:nth-child(2) > td:nth-child(4) > span")
          'div.box_type_l > table.type_2 > tbody > tr > td > span.tah.p11.red02',
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Requesting to fetch before UI drawing starts
    fetchProducts();
  }

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
                child: stockName == null
                    ? Center(
                        child:
                            CircularProgressIndicator(), // Loads Circular Loading Animation
                      )
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.zero,
                        itemCount: stockName == null ? 0 : stockName?.length,
                        itemBuilder: (BuildContext context, int index) {
                          var logoDatas = logos![index];
                          var stocksplit1 = stockName?[index]
                              .toString()
                              .replaceAll('{title:', '');
                          var stocksplit2 = stocksplit1!
                              .replaceAll(', attributes:  null}}', '');
                          var rateSplit1 = stockRateScrap?[index]
                              .toString()
                              .replaceAll('{title: ', '');
                          var ratePriceSplit1 = stockAgoRateScrap?[index]
                              .toString()
                              .replaceAll('{title: ', '');
                          var stockRatePrice = ratePriceSplit1!.replaceAll(
                              ', attributes: {tah p11 red01: null}}', '');
                          var stockRate = rateSplit1!.replaceAll(
                              ', attributes: {tah p11 red01: null}}', '');
                          var stockTitle = cp949.decodeString(stocksplit2);
                          if (stockTitle != ' ') {
                            return SizedBox(
                              height: 150,
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
                                                  items: stockTitle,
                                                  logos: logoDatas,
                                                  rates: stockRate,
                                                  prices: stockRatePrice)));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height: 18,
                                            width: 18,
                                            child: IconButton(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              // splashRadius: 12,
                                              onPressed: () {
                                                //즐겨찾기 추가
                                                setState(() {
                                                  var i = 0;
                                                  favoriteList.add(Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Palette.bgColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Palette
                                                                .outlineColor,
                                                            offset: Offset(
                                                              0,
                                                              2.0,
                                                            ),
                                                            blurRadius: 2.0,
                                                          )
                                                        ],
                                                      ),
                                                      child: SizedBox(
                                                        height: 150,
                                                        child: Card(
                                                          shadowColor:
                                                              Colors.black,
                                                          elevation: 0,
                                                          color:
                                                              Palette.bgColor,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      favoriteList
                                                                          .remove(
                                                                              favoriteList[i]);
                                                                      i++;
                                                                    });
                                                                  },
                                                                  icon: Icon(
                                                                      Icons
                                                                          .favorite,
                                                                      size: 18,
                                                                      color: Palette
                                                                          .outlineColor)),
                                                              Container(
                                                                width: 50,
                                                                height: 50,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border
                                                                      .all(
                                                                    width: 1,
                                                                    color: Palette
                                                                        .outlineColor,
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(stockTitle),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Text(
                                                                      stockRatePrice),
                                                                  Text(
                                                                      stockRate)
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
                                          Text(cp949
                                              .decodeString(stockName![index])),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(stockRatePrice),
                                              Text(
                                                stockRate,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return SizedBox.shrink();
                          }
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
