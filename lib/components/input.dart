// ignore_for_file: unnecessary_const
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';

// ignore: non_ant_identifier_names, non_constant_identifier_names
inputText([Textinput, label, obscureText, controller]) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 500,
        child: TextField(
          decoration: InputDecoration(
            // ignore: prefer__ructors
            border: const OutlineInputBorder(
                borderRadius:
                    const BorderRadius.all(const Radius.circular(10))),
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

inputInt([Textinput, label, obscureText, controller]) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 500,
        child: TextField(
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            // ignore: prefer__ructors
            border: const OutlineInputBorder(
                borderRadius:
                    const BorderRadius.all(const Radius.circular(10))),
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
