import 'package:flutter/material.dart';

navigationpage({page, context}) {
  return Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => page()));
}
