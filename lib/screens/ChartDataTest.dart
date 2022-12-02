import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:cp949/cp949.dart' as cp949;

class ChartDataTest extends StatefulWidget {
  const ChartDataTest({super.key, required this.chartcode});
  final chartcode;
  @override
  State<ChartDataTest> createState() => _ChartDataTestState();
}

class _ChartDataTestState extends State<ChartDataTest> {
  List<String> chartData = [];
  Future getsociologyData() async {
    final url = Uri.parse(
        'https://finance.naver.com/item/sise_time.naver?code=005930&thistime=20221202161058&page=1');
    final reponse = await http.get(url);
    dom.Document html = dom.Document.html(reponse.body);

    final chartPrice = html
        .querySelectorAll(
            'table.type2 > tbody > tr > td > span') //body > table.type2 > tbody > tr:nth-child(11) > td:nth-child(2) > span
        .map((e) => e.innerHtml.trim())
        .toList();
    final title = html
        .querySelectorAll('table.type2 > tbody > tr:nth-child(1) > th')
        .map((e) => e.innerHtml.trim())
        .toList();
    // for (var i = 0; i < chartPrice.length - 9; i++) {
    //   chartData.add(chartPrice[i]);
    // }
    for (final i in chartPrice) {
      debugPrint(i);
    }
    print('주식싯가 갯수${chartPrice.length}');
    print('주식싯가 갯수${cp949.decodeString(title[0])}');
    // print('${chartData.length}');
    // print('$chartData');
  }

  @override
  void initState() {
    super.initState();
    getsociologyData();
    // Requesting to fetch before UI drawing starts
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('adsf'),
      ),
      body: Container(child: chartContainer(005930)),
    );
  }
}

Widget chartContainer(chartCode) {
  return Container(
    child: Column(children: [Text('data'), Text('data'), Text('chartCode')]),
  );
}
