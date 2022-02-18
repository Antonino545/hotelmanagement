import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
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

Future<void> singup(
    [context, password_1, password_2, box, TextEditingController email]) async {
  if (password_1.text != password_2.text) {
    Alert(context, "Le password non coincidono");
  } else {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.text, password: email.text);
  }
}

signInWithGoogle()  {

}
login_with_facebook() {}
