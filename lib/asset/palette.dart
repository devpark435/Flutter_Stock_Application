import 'package:flutter/material.dart';

/**색상모음집 */
class Palette {
  // static get bgColor => Color(0xffFEF5ED);
  static get bgColor => Color.fromARGB(255, 255, 255, 255);
  static get appbarColor => Color.fromARGB(255, 255, 255, 255);
  static get outlineColor => Color.fromARGB(255, 95, 156, 247);
  static get listColor => Color.fromARGB(255, 255, 255, 255);
  static get containerShadow => Color(0xffADC2A9);
  static get moneyColor => Color.fromARGB(255, 95, 156, 247);
  static get moneyOffColor => Color.fromARGB(255, 193, 89, 81);
}

class Styles {
  //MARK: -itemName
  static const TextStyle headerText =
      TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w900);
  static const TextStyle mainHeaderText = TextStyle(
      color: Color.fromARGB(237, 90, 163, 222),
      fontSize: 30,
      fontWeight: FontWeight.w900);
  static const TextStyle mainHeaderText2 = TextStyle(
      color: Color.fromARGB(255, 67, 125, 172),
      fontSize: 30,
      fontWeight: FontWeight.w900);
  static const TextStyle emText =
      TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600);
  static const TextStyle subText =
      TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600);
}
