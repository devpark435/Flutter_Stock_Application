import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../asset/palette.dart';
import '../screens/NewsPage.dart';

Widget stockTips(chartName, cnt) {
  return GestureDetector(
    child: Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      width: MediaQuery.of(cnt).size.width * 0.4,
      height: 150,
      decoration: BoxDecoration(
        color: Palette.bgColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Palette.outlineColor,
            offset: Offset(0, 5),
          )
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            Icons.bar_chart,
            size: 60,
          ),
          Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    '주식차트',
                    style: Styles.subText,
                  ),
                  Text(
                    '보는 방법',
                    style: Styles.subText,
                  )
                ],
              )),
        ],
      ),
    ),
    onTap: () async {
      final urlStart = Uri.parse('https://ddnews.co.kr/stock-chart/');
      if (await canLaunchUrl(urlStart)) {
        launchUrl(urlStart);
      } else {
        // ignore: avoid_print
        print("Can't launch $urlStart");
      }
    },
  );
}
