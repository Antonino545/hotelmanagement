import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_icons/flutter_icons.dart';

Widget button_ico({text, icon, onpressed, context}) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 50,
        width: 500.0,
        child: OutlinedButton.icon(
          onPressed: () => onpressed,
          label: Text(text),
          icon: Icon(icon),
          style: OutlinedButton.styleFrom(
            textStyle:
                const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            elevation: 20,
            backgroundColor: Colors.transparent,
            primary: Colors.white,
            side: const BorderSide(color: Colors.white),
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(50)),
          ),
        ),
      ));
}

Widget button_pageTransition({text, onpressed, context}) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 50,
        width: 500.0,
        child: OutlinedButton(
          onPressed: () => {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.leftToRight, child: onpressed))
          },
          child: Text(
            text,
          ),
          style: OutlinedButton.styleFrom(
            textStyle:
                const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            elevation: 20,
            backgroundColor: Colors.transparent,
            primary: Colors.white,
            side: BorderSide(color: Colors.white),
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(50)),
          ),
        ),
      ));
}

button(text, onpressed) async {
  // todo da perfezzionare il funzionamento
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 50,
        width: 500.0,
        child: OutlinedButton(
          onPressed: () {
            onpressed();
          },
          child: Text(
            text,
          ),
          style: OutlinedButton.styleFrom(
            textStyle:
                const TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
            elevation: 20,
            backgroundColor: Colors.transparent,
            primary: Colors.white,
            side: BorderSide(color: Colors.white),
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(50)),
          ),
        ),
      ));
}
