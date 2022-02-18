import 'dart:io';
import 'dart:js';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/screen/ElencoScreen/elenco_ospiti_generale.dart';
import 'package:page_transition/page_transition.dart';

import 'AlertDialog.dart';

Future<void> login(
    {context,
    box,
    TextEditingController email,
    TextEditingController password}) async {
  print(email.text);
  print(password.text);

  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.text, password: password.text);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
  FirebaseAuth.instance.userChanges().listen((User user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.leftToRight,
              child: ElencoOspitiGenerali()));
      print('Login success');
    }
  });
}

signInWithGoogle() {}
login_with_facebook() {}
