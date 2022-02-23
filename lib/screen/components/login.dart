import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/Screen/components/AlertDialog.dart';
import 'package:hotelmanagement/screen/ElencoScreen/elenco_ospiti_generale.dart';
import 'package:page_transition/page_transition.dart';

Future<void> login(
    {context,
    box,
    TextEditingController email,
    TextEditingController password}) async {
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

Singup(
    [TextEditingController password_1,
    TextEditingController password_2,
    TextEditingController email,
    context]) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  if (password_1.text != password_2.text) {
    await Alert(context, "Le password non coincidono");
  } else {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: email.text, password: password_1.text)
          .then((value) async {
        User user = FirebaseAuth.instance.currentUser;

        await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          'email': email.text,
          'password': password_1.text,
        });
      });
      print("Signed Up");
    } catch (e) {
      if (e.code == 'weak-password') {
        await Alert(context, "Le password non rispetta i criteri di sicurezza");
      } else if (e.code == 'email-already-in-use') {
        await Alert(context, "Questa mail é gia utilizzata");
      }
    }
  }
}

signInWithGoogle() {}
login_with_facebook() {}
