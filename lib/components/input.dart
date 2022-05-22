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
<<<<<<< HEAD
                borderRadius: const BorderRadius.all(Radius.circular(10))),
=======
                borderRadius:
                    const BorderRadius.all(const Radius.circular(10))),
>>>>>>> 4522cd1b23c871a889b634b83c00fa46a0de2785
          ),
          keyboardType: textInput,
          obscureText: obscureText,
          controller: controller,
        ),
      ),
    )
  ]);
}

<<<<<<< HEAD
inputTextCard([textInput, label, text]) {
=======
// ignore: non_constant_identifier_names
inputTextCard([Textinput, label, text]) {
>>>>>>> 4522cd1b23c871a889b634b83c00fa46a0de2785
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
