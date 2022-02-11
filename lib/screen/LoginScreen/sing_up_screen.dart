// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class singup extends StatelessWidget {
  get value => null;

  @override
  Widget build(BuildContext context) {
    var password_1 = TextEditingController();
    var password_2 = TextEditingController();
    var email = TextEditingController();
    String box;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Crea Account",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Crea il tuo nuovo account",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                        controller: email,
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Password",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                        controller: password_1,
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Reinserisci Password",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                        controller: password_2,
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  MaterialButton(
                    minWidth: double.infinity,
                    color: Colors.blue,
                    height: 60,
                    onPressed: () async {
                      if (password_1.text != password_2.text) {
                        box = "Le password non concidono";
                        showAlertDialog(context, box);
                      } else {
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                                  email: email.text, password: password_1.text);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            box =
                                "Le password non rispetta i criteri di sicurezza";
                            showAlertDialog(context, box);
                          } else if (e.code == 'email-already-in-use') {
                            box = "La mail e già in uso";
                            showAlertDialog(context, box);
                          }
                        }
                      }
                      var currentUser = FirebaseAuth.instance.currentUser;
                      print("UID: " + currentUser.uid.toString());
                      var firebaseUser = FirebaseAuth.instance.currentUser;
                      var firebase = FirebaseFirestore.instance;
                      firebase.collection("Users").doc(currentUser.uid).set({
                        "Mail": currentUser.email,
                      }, SetOptions(merge: true)).then((_) {
                        print("success!");
                      });
                    },
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      "Crea Account",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Hai un account?",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => login())),
                        child: Text(
                          "Accedi al tuo account",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, box1) {
    // set up the button
    Widget okButton = FlatButton(
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
}
