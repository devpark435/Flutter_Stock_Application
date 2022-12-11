import '../screens/NewsPage.dart';
import 'package:flutter/material.dart';
import '../asset/palette.dart';

Widget newsArea(chartName, cnt) {
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
              Icons.newspaper,
              size: 40,
            ),
            Container(
                alignment: Alignment.center,
                child: Column(
                  children: [Text('${chartName}'), Text('관련 뉴스')],
                )),
          ],
        )),
    onTap: () => {
      Navigator.push(
          cnt,
          MaterialPageRoute(
              builder: (cnt) => NewsPage(
                    title: 'title',
                    itemName: chartName,
                  )))
    },
  );
}

// actions: [
//               new IconButton(
//                 icon: new Icon(Icons.newspaper),
//                 tooltip: 'NewsScrap',
//                 onPressed: () => {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => NewsPage(
//                                 title: 'title',
//                                 itemName: widget.items,
//                               )))
//                 },
//               )
//             ],