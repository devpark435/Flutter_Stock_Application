import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:ffi';
import 'ChartPage.dart';
import 'ListPage.dart';
import 'package:flutter/material.dart';
import 'package:stock_flutter_app/widgets/customWidget.dart';
import '../asset/palette.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show Utf8Encoder, utf8;
import 'package:cp949/cp949.dart' as cp949;

class stockList extends StatefulWidget {
  const stockList({super.key});

  @override
  State<stockList> createState() => _stockListState();
}

class _stockListState extends State<stockList> {
  // initialize WebScraper by passing base url of website
  final webScraper = WebScraper('https://finance.naver.com/');
  // Response of getElement is always List<Map<String, dynamic>>
  List<String>? stockName;
  late List<String> stockRateScrap = []; //등락률
  late List<String> stockAgoRateScrap = []; //등락금액
  late List<String> stockDataScrap;

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
        stockDataScrap = webScraper.getElementTitle(
          //등락률, 전일가격scrap
          //document.querySelector("#contentarea > div.box_type_l > table.type_2 > tbody > tr:nth-child(2) > td:nth-child(5) > span")
          //
          'div.box_type_l > table.type_2 > tbody > tr > td >span.tah.p11',
        );
        
        for (var i = 0; i < stockDataScrap.length; i++) {//등락률 전일가격 나누기
          if (i % 2 == 0) {
            stockAgoRateScrap.add(stockDataScrap[i]);
          } else {
            stockRateScrap.add(stockDataScrap[i]);
          }
        }
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
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text('List_Test'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: stockName == null
                ? Center(
                    child:
                        CircularProgressIndicator(), // Loads Circular Loading Animation
                  )
                : ListView.builder(
                    itemCount: stockName!.length,
                    itemBuilder: (BuildContext context, int index) {
                      // if (stockTitle != ' ') {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Card(
                            elevation: 0,
                            color: Palette.bgColor,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Palette.bgColor,
                                  border: Border.all(
                                      width: 1, color: Palette.outlineColor),
                                  borderRadius: BorderRadius.circular(25)),
                              child: Row(
                                children: [
                                  Container(
                                    //News List Container
                                    decoration: BoxDecoration(
                                        color: Palette.bgColor,
                                        border: Border.all(
                                            width: 1,
                                            color: Palette.outlineColor),
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Column(
                                      children: [
                                        Padding(
                                          //News Title
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              '${cp949.decodeString(stockName![index])}'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    //News List Container
                                    decoration: BoxDecoration(
                                        color: Palette.bgColor,
                                        border: Border.all(
                                            width: 1,
                                            color: Palette.outlineColor),
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Column(
                                      children: [
                                        Padding(
                                          //News Title
                                          padding: const EdgeInsets.all(8.0),
                                          child:
                                              Text('${stockRateScrap[index]}'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    //News List Container
                                    decoration: BoxDecoration(
                                        color: Palette.bgColor,
                                        border: Border.all(
                                            width: 1,
                                            color: Palette.outlineColor),
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Column(
                                      children: [
                                        Padding(
                                          //News Title
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              '${stockAgoRateScrap[index]}'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                      // } else {
                      //   return SizedBox.shrink();
                      // }

                      ;
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
