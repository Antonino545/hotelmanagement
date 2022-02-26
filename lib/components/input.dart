import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
inputText(Textinput, label, obscureText, [var controller]) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 500,
        child: TextField(
          decoration: InputDecoration(
            // ignore: prefer_const_constructors
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            labelText: label,
            hintText: "inserisci " + label,
          ),
          keyboardType: Textinput,
          obscureText: obscureText,
          controller: controller,
        ),
      ),
    )
  ]);
}
