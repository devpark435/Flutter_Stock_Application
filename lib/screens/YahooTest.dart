import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:yahoofin/src/features/information/stock_info.dart';
import 'package:yahoofin/src/models/stock_chart.dart';
import 'package:yahoofin/src/models/stock_meta.dart';
import 'package:yahoofin/src/models/stock_quote.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yahoofin/yahoofin.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:url_launcher/url_launcher.dart';

class YahooTest extends StatefulWidget {
  const YahooTest({super.key});

  @override
  State<YahooTest> createState() => _YahooTestState();
}

class _YahooTestState extends State<YahooTest> {
  var i = 0;

  @override
  void initState() {
    super.initState();

    // Requesting to fetch before UI drawing starts
  }

  @override
  Widget build(BuildContext context) {
    List<String> chartData = [];
    Future getsociologyData() async {
      final url = Uri.parse('http://127.0.0.1:57339/');
      final reponse = await http.get(url);
      dom.Document html = dom.Document.html(reponse.body);
    }

    Future<void> launchUrlStart({required String url}) async {
      if (!await launchUrl(Uri.parse(url))) {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        child: Center(
          child: Container(
            height: 100,
            width: 100,
            color: Colors.amber,
          ),
        ),
        onTap: () async {
          //http://10.0.2.2:5000/삼성전자
          final url = Uri.parse("http://10.0.2.2:5000/005930");
          launchUrl(url);
        },
      ),
    );
  }
}