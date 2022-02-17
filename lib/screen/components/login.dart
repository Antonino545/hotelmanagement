import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/Screen/elenco_ospiti_generale.dart';
import 'package:page_transition/page_transition.dart';

import 'AlertDialog.dart';

Future<void> login({context, box, email, password}) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.text, password: password.text);
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
}

singup({password_1, password_2, box, email, context}) async {
  if (password_1.text != password_2.text) {
    box = "Le password non concidono";
    showAlertDialog(password_2, box);
  } else {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password_1.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        box = "Le password non rispetta i criteri di sicurezza";
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
}

login_with_google() {}
login_with_facebook() {}
