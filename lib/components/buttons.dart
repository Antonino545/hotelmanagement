import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

Widget buttonIco({text, icon, onpressed, context}) {
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
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 10.0,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(50)),
          ),
        ),
      ));
}

Widget buttonPageTransition({text, onpressed, context}) {
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
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 10.0,
                  style: BorderStyle.solid,
                ),
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
            textStyle: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 20, color: Colors.teal),
            elevation: 20,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(50)),
          ),
        ),
      ));
}
