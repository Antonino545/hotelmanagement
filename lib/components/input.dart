// ignore_for_file: unnecessary_const
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';

// ignore: non_ant_identifier_names, non_constant_identifier_names
inputText([Textinput, label, obscureText, controller]) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          hintText: "inserisci " + label,
        ),
        keyboardType: Textinput,
        obscureText: obscureText,
        controller: controller,
      ),
    )
  ]);
}

inputInt([Textinput, label, obscureText, controller]) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          labelText: label,
          hintText: "inserisci " + label,
        ),
        keyboardType: Textinput,
        obscureText: obscureText,
        controller: controller,
      ),
    )
  ]);
}
