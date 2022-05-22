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
        height: 50,
        child: TextField(
          decoration: InputDecoration(
            labelText: label,
            hintText: "inserisci " + label,
            border: const OutlineInputBorder(
                borderRadius:
                    const BorderRadius.all(const Radius.circular(10))),
          ),
          keyboardType: Textinput,
          obscureText: obscureText,
          controller: controller,
        ),
      ),
    )
  ]);
}

inputInt([textInput, label, obscureText, controller]) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 500,
        height: 50,
        child: TextField(
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            labelText: label,
            hintText: "inserisci " + label,
            border: const OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10))),
          ),
          keyboardType: textInput,
          obscureText: obscureText,
          controller: controller,
        ),
      ),
    )
  ]);
}

inputTextCard([textInput, label, text]) {
  var controller = TextEditingController();
  controller.text = text.toString();
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Text(label + ":"),
        SizedBox(
          width: 150,
          height: 50,
          child: TextField(
            keyboardType: textInput,
            controller: controller,
          ),
        ),
      ],
    ),
  );
}
