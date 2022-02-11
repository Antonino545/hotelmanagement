import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, box1) {
  // set up the button
  Widget okButton = MaterialButton(
    child: Text("Ok"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  AlertDialog alert;
  CupertinoAlertDialog alertios;
  // set up the AlertDialog
  if (Platform.isAndroid) {
    // Android-specific code
    alert = AlertDialog(
      title: Text(box1),
      actions: [
        okButton,
      ],
      elevation: 24.0,
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  } else {
    // iOS-specific code
    alertios = CupertinoAlertDialog(
      title: Text(box1),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertios;
      },
    );
  }
}
