import 'package:flutter/material.dart';

Widget imput_text({controller, label, obscureText = false}) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          labelText: label,
          hintText: "inserisci " + label,
        ),
        keyboardType: TextInputType.emailAddress,
        controller: controller,
      ),
    )
  ]);
}
