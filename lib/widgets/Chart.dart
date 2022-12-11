import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../asset/palette.dart';
import 'package:webview_flutter/webview_flutter.dart';

//chartArea
Widget chartArea(chartName) {
  String url = "";
  switch (chartName) {
    case '삼성전자':
      url =
          "https://ssl.pstatic.net/imgfinance/chart/item/candle/week/005930.png?";
      break;
    case 'LG에너지솔루션':
      url =
          "https://ssl.pstatic.net/imgfinance/chart/item/candle/week/373220.png?";
      break;
    default:
  }
  return GestureDetector(
      child: Container(
          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
          height: 180,
          decoration: BoxDecoration(
            color: Palette.bgColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: WebView(
              initialUrl: url,
              zoomEnabled: true,
              javascriptMode: JavascriptMode.unrestricted,
            ),
          )));
}
