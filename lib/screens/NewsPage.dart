import 'dart:ffi';
import 'ChartPage.dart';
import 'ListPage.dart';
import 'package:flutter/material.dart';
import 'package:stock_flutter_app/widgets/customWidget.dart';
import '../asset/palette.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class NewsPage extends StatefulWidget {
  const NewsPage({super.key, required this.title, required this.itemName});
  final String title;
  final String itemName;
  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  int searchText = 0;
  // initialize WebScraper by passing base url of website
  final webScraper = WebScraper('https://www.mk.co.kr');
  late String keyWorld = widget.itemName;
  // Response of getElement is always List<Map<String, dynamic>>
  List<Map<String, dynamic>>? productNames;
  late List<Map<String, dynamic>> productDescriptions;

  void fetchProducts() async {
    // Loads web page and downloads into local state of library
    if (await webScraper.loadWebPage('/search?word=' + '${keyWorld}')) {
      setState(() {
        // getElement takes the address of html tag/element and attributes you want to scrap from website
        // it will return the attributes in the same order passed
        productNames = webScraper.getElement(
            'div.sec_body > div.result_news_wrap > ul > li > a.news_item > div.txt_area > h3.news_ttl',
            ['title']);
        productDescriptions = webScraper.getElement(
            'div.sec_body > div.result_news_wrap>ul#list_area > li > a.news_item',
            ['href', 'news']);
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
          title: Text('${widget.itemName} NewsPage'),
        ),
        body: SafeArea(
            child: productNames == null
                ? Center(
                    child:
                        CircularProgressIndicator(), // Loads Circular Loading Animation
                  )
                : ListView.builder(
                    itemCount: productNames!.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map<String, dynamic> attributes =
                          productDescriptions![index]['attributes'];
                      var productSample = productNames?[index]
                          .toString()
                          .replaceAll('{title:', '');
                      var productNameText =
                          productSample!.replaceAll('attributes:  null}}', '');
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Card(
                          shadowColor: Palette.containerShadow,
                          color: Palette.bgColor,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${productNameText}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: <Widget>[
                                    // Container(
                                    //   child: Text(''),
                                    // ),
                                    InkWell(
                                      onTap: () {
                                        // uses UI Launcher to launch in web browser & minor tweaks to generate url
                                        launch(Uri.encodeFull(
                                            // webScraper.baseUrl! +
                                            attributes['href']));
                                      },
                                      child: Text(
                                        'View Product',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })));
  }
}
