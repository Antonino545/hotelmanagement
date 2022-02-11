import 'dart:io';

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

login_with_google() {}
login_with_facebook() {}
