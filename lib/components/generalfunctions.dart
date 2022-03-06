import 'package:flutter/material.dart';

navigationpage({page, context}) {
  return Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => page()));
}

textCard(documentSnapshot, String text, String doc) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Row(
      children: [
        Text(text + documentSnapshot[doc].toString()),
      ],
    ),
  );
}
