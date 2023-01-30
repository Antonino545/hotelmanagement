import 'package:flutter/material.dart';

navigationpage({page, context}) {
  return Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => page()));
}

textCard(docSnap, String text, String doc) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Text(text + docSnap[doc].toString()),
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
