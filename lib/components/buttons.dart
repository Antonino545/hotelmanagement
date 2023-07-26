import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

Widget buttonPageTransition({text, onpressed, context}) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton(
        onPressed: () => {
          Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: onpressed))},
        child: Text(text),
      ));
}


