import 'package:flutter/material.dart';
import 'package:stock_flutter_app/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../asset/palette.dart';
import 'package:webview_flutter/webview_flutter.dart';

//chartArea
Widget chartData(chartName) {
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
  return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      height: 280,
      decoration: BoxDecoration(
        color: Palette.bgColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Text('${chartName}'),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 180,
            child: WebView(
              initialUrl: url,
              zoomEnabled: true,
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.zoom_in),
                onPressed: () async {
                  final urlStart = Uri.parse(url);
                  if (await canLaunchUrl(urlStart)) {
                    launchUrl(urlStart);
                  } else {
                    // ignore: avoid_print
                    print("Can't launch $url");
                  }
                },
              ),
              Text('차트 크게보기')
            ],
          )
        ],
      ));
}
