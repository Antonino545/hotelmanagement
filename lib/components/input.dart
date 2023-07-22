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
            // ignore: prefer_interpolation_to_compose_strings
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
            // ignore: prefer_interpolation_to_compose_strings
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
inputPassword([_isObscure, password, onpress]){
  Padding(
    padding: const EdgeInsets.all(10),
    child: SizedBox(
      width: 500,
      height: 50,
      child: TextField(
        decoration: InputDecoration(
          suffixIcon: Padding(
              padding:
              const EdgeInsetsDirectional.only(end: 12.0),
              child: IconButton(
                  onPressed: () {
                 onpress();
                  },
                  icon: Icon(_isObscure
                      ? Icons.visibility
                      : Icons.visibility_off))),
          labelText: "Password",
          hintText: "Inserisci la password",
          border: const OutlineInputBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(10))),
        ),
        obscureText: _isObscure,
        controller: password,
      ),
    ),
  );
}
inputTextCard([textInput, label, controller]) {
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
