// ignore_for_file: file_names
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screen/responsive/splitview.dart';

//alert is a function that show a dialog with a message
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

//alertDelete is a fuctions that show a dialog to confirm the delete of a document in firebase firestore
Future<void> alertDelete(BuildContext context, box, user, docSnap, delete) {
  try {
    if (Platform.isIOS) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            content: Text(box),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text('Si'),
                onPressed: () {
                  try {
                    delete;
                  } catch (e) {
                    alert(context, e.toString());
                  }
                },
              ),
              CupertinoDialogAction(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(box),
            actions: <Widget>[
              Row(
                children: [
                  TextButton(
                    child: const Text('Si'),
                    onPressed: () {
                      try {
                        delete;
                      } catch (e) {
                        alert(context, e.toString());
                      }
                    },
                  ),
                  TextButton(
                      child: const Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ],
          );
        },
      );
    }
  } catch (e) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(box),
            actions: <Widget>[
              Row(
                children: [
                  TextButton(
                    child: const Text('Si'),
                    onPressed: () {
                      try {
                        delete;
                      } catch (e) {
                        alert(context, e.toString());
                      }
                    },
                  ),
                  TextButton(
                      child: const Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ],
          );
        });
  }
}
