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
    ),
    onTap: () async {
      final urlStart = Uri.parse('url');
      if (await canLaunchUrl(urlStart)) {
        launchUrl(urlStart);
      } else {
        // ignore: avoid_print
        print("Can't launch $urlStart");
      }
    },
  );
}
