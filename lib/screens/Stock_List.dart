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

class stockLsit extends StatefulWidget {
  const stockLsit({super.key});

  @override
  State<stockLsit> createState() => _stockLsitState();
}

class _stockLsitState extends State<stockLsit> {
  // initialize WebScraper by passing base url of website
  final webScraper = WebScraper('https://finance.naver.com/');
  // Response of getElement is always List<Map<String, dynamic>>
  List<Map<String, dynamic>>? stockName;
  late List<Map<String, dynamic>> stockRateScrap;
  late List<Map<String, dynamic>> stockAgoRateScrap;

  void fetchProducts() async {
    // Loads web page and downloads into local state of library
    if (await webScraper.loadWebPage('sise/sise_market_sum.naver')) {
      setState(() {
        // getElement takes the address of html tag/element and attributes you want to scrap from website
        // it will return the attributes in the same order passed
        stockName = webScraper.getElement(
            //주식명 scrap
            // document.querySelector("#contentarea > div.box_type_l > table.type_2 > tbody > tr:nth-child(2) > td:nth-child(2) > a")
            'div.box_type_l > table.type_2 > tbody > tr > td > a',
            ['title']);
        stockRateScrap = webScraper.getElement(
            //등락률 scrap
            //document.querySelector("#contentarea > div.box_type_l > table.type_2 > tbody > tr:nth-child(2) > td:nth-child(5) > span")
            //
            'div.box_type_l > table.type_2 > tbody > tr > td > span.tah.p11.red01',
            ['tah p11 red01']);
        stockAgoRateScrap = webScraper.getElement(
            //전일대비 scrap
            //document.querySelector("#contentarea > div.box_type_l > table.type_2 > tbody > tr:nth-child(2) > td:nth-child(4) > span")
            'div.box_type_l > table.type_2 > tbody > tr > td > span.tah.p11.red02',
            ['tah p11 red01']);
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
      body: Container(
        child: stockName == null
            ? Center(
                child:
                    CircularProgressIndicator(), // Loads Circular Loading Animation
              )
            : ListView.builder(
                itemCount: stockName!.length,
                itemBuilder: (BuildContext context, int index) {
                  var stocksplit1 =
                      stockName?[index].toString().replaceAll('{title:', '');
                  var stocksplit2 =
                      stocksplit1!.replaceAll(', attributes:  null}}', '');
                  var rateSplit1 = stockRateScrap?[index]
                      .toString()
                      .replaceAll('{title: ', '');
                  var ratePriceSplit1 = stockAgoRateScrap?[index]
                      .toString()
                      .replaceAll('{title: ', '');
                  var stockRatePrice = ratePriceSplit1!
                      .replaceAll(', attributes: {tah p11 red01: null}}', '원');
                  var stockRate = rateSplit1!
                      .replaceAll(', attributes: {tah p11 red01: null}}', '');
                  var stockTitle = cp949.decodeString(stocksplit2);

                  if (stockTitle != ' ') {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Card(
                          elevation: 0,
                          color: Palette.bgColor,
                          child: Row(
                            children: [
                              Container(
                                //News List Container
                                decoration: BoxDecoration(
                                    color: Palette.bgColor,
                                    border: Border.all(
                                        width: 1, color: Palette.outlineColor),
                                    borderRadius: BorderRadius.circular(25)),
                                child: Column(
                                  children: [
                                    Padding(
                                      //News Title
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('${stockTitle}'),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                //News List Container
                                decoration: BoxDecoration(
                                    color: Palette.bgColor,
                                    border: Border.all(
                                        width: 1, color: Palette.outlineColor),
                                    borderRadius: BorderRadius.circular(25)),
                                child: Column(
                                  children: [
                                    Padding(
                                      //News Title
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('${stockRate}'),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                //News List Container
                                decoration: BoxDecoration(
                                    color: Palette.bgColor,
                                    border: Border.all(
                                        width: 1, color: Palette.outlineColor),
                                    borderRadius: BorderRadius.circular(25)),
                                child: Column(
                                  children: [
                                    Padding(
                                      //News Title
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('${stockRatePrice}'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }

                  ;
                },
              ),
      ),
    );
  }
}
