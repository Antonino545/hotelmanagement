// ignore_for_file: file_names
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> alert(BuildContext context, String box) async {
  try {
    if (Platform.isIOS) {
      return showDialog<void>(
          context: context,
          builder: (_) => CupertinoAlertDialog(
                content: Text(box),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: const Text('Okay'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ));
    } else {
      return showDialog<void>(
          context: context,
          builder: (_) => AlertDialog(
                content: Text(box),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Okay'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ));
    }
  } catch (e) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return AlertDialog(
          title: Text(box),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
