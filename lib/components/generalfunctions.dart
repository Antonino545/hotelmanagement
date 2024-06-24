import 'package:flutter/material.dart';

navigationpage({page, context}) {
  return Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => page()));
}


Widget textCard(var docSnap, String text, String doc, [String symbol = '']) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Text(text + docSnap[doc].toString() + symbol),
      ],
    ),
  );
}
Widget textCard2(String text, String doc, [String symbol = '']) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Text(text + doc + symbol),
      ],
    ),
  );
}

intCard(String text, int num) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Text(text + num.toString()),
      ],
    ),
  );
}
