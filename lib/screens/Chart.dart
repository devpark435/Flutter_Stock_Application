import 'package:flutter/material.dart';
import '../asset/palette.dart';

Widget chartArea(chartName) {
  return GestureDetector(
    child: Container(
        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
        width: 150,
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
              size: 40,
            ),
            Text('${chartName} 차트 확인하기')
          ],
        )),
  );
}
