import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showAlertDialog(BuildContext context, box1) {
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
    showDialog<void>(
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
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return alertios;
      },
    );
  }
}

Future<void> Alert(BuildContext context, box) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(box),
        actions: <Widget>[
          OutlinedButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
