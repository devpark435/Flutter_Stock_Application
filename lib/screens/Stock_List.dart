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
  late List<String> stockRateScrap;
  late List<String> stockAgoRateScrap;
  var stockRateScrapDocument;

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
          'div.box_type_l > table.type_2 > tbody > tr > td >span.tah.p11',
        );
        stockAgoRateScrap = webScraper.getElementTitle(
          //전일대비 scrap
          //document.querySelector("#contentarea > div.box_type_l > table.type_2 > tbody > tr:nth-child(2) > td:nth-child(4) > span")
          'div.box_type_l > table.type_2 > tbody > tr > td > span.tah.p11',
        );
        stockRateScrapDocument =
            ("#contentarea > div.box_type_l > table.type_2 > tbody > tr:nth-child(2) > td:nth-child(5) > span");
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
                                              Text('${stockRateScrapDocument}'),
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
