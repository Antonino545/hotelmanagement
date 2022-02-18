import 'package:flutter/material.dart';

input_text(Textinput, label, obscureText, [var controller]) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 500,
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
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
