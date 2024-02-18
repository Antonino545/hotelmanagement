import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// This function creates a TextField widget with the specified parameters.
///
/// [textInput] is the type of input for the TextField.
/// [label] is the label text for the TextField.
/// [controller] is the TextEditingController for the TextField.
/// [obscureText] determines whether the TextField should obscure the text. Default is false.
/// [isNumeric] determines whether the TextField should only accept numeric input. Default is false.
inputText({required TextInputType textInput, required String label, required TextEditingController controller, bool obscureText = false, bool isNumeric = false}) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: SizedBox(
      width: 500,
      height: 50,
      child: TextField(
        inputFormatters: isNumeric ? [FilteringTextInputFormatter.digitsOnly] : [],
        decoration: InputDecoration(
          labelText: label,
          hintText: "inserisci $label",
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        keyboardType: textInput,
        obscureText: obscureText,
        controller: controller,
      ),
    ),
  );
}

/// This function creates a TextField widget with the specified parameters.
///
/// [label] is the label text for the TextField.
/// [controller] is the TextEditingController for the TextField.
/// The TextField is set to accept text input and not obscure the text.
Widget defaultInputText({required String label, required TextEditingController controller}) {
  return inputText(
    textInput: TextInputType.text,
    label: label,
    controller: controller,
    obscureText: false,
    isNumeric: false,
  );
}

/// This function creates a TextField widget with the specified parameters.
///
/// [label] is the label text for the TextField.
/// [controller] is the TextEditingController for the TextField.
/// The TextField is set to accept numeric input and not obscure the text.
Widget defaultInputNumber({required String label, required TextEditingController controller}) {
  return inputText(
    textInput: TextInputType.number,
    label: label,
    controller: controller,
    obscureText: false,
    isNumeric: true,
  );
}

/// This function creates a TextField widget within a Card widget.
///
/// [textInput] is the type of input for the TextField.
/// [label] is the label text for the TextField.
/// [controller] is the TextEditingController for the TextField.
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