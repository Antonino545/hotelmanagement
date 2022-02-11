// ignore: file_names
// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/screen/LoginScreen/sing_up_screen.dart';
import 'package:hotelmanagement/screen/elenco_ospiti_generale.dart';
import 'package:page_transition/page_transition.dart';

class login extends StatefulWidget {
  @override
  _Login_mobileState createState() => _Login_mobileState();
}

class _Login_mobileState extends State<login> {
  @override
  Widget build(BuildContext context) {
    String box;
    var password = TextEditingController();
    var email = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  "Accedi",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Entra nel tuo account",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  LoginImput(label: "Email", controller: email),
                  LoginImput(
                      label: "Password",
                      controller: password,
                      obscureText: true)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  MaterialButton(
                    minWidth: 200,
                    color: Colors.blue,
                    height: 60,
                    onPressed: () async {
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                                email: email.text, password: password.text);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          box = "Utente  non trovata";
                          showAlertDialog(context, box);
                        } else if (e.code == 'wrong-password') {
                          box = "La password é errata";
                          showAlertDialog(context, box);
                        } else {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.leftToRight,
                                  child: ElencoOspitiGenerali()));
                        }
                      }
                    },
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      "Login",
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
                        "Non hai un account?",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => singup())),
                        child: Text(
                          "Crea Account",
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

  Widget LoginImput({controller, label, obscureText = false}) {
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
}
