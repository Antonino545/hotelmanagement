import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hotelmanagement/components/AlertDialog.dart';
import 'package:hotelmanagement/drawer.dart';
import 'package:hotelmanagement/screen/ElencoScreen/elenco_ospiti_generale.dart';
import 'package:hotelmanagement/screen/responsive/splitview.dart';

import '../screen/LoginScreen/login_screen.dart';

Future<void> login(
    {context,
    box,
    required TextEditingController email,
    required TextEditingController password}) async {
  if (email.text == null) {
    alert(context, "devi inserire la mail");
    return;
  }
  if (password.text == null) {
    alert(context, "devi inserire la password");
    return;
  }
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.text, password: password.text);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      if (kDebugMode) {
        print('No user found for that email.');
      }
    } else if (e.code == 'wrong-password') {
      if (kDebugMode) {
        print('Wrong password provided for that user.');
      }
    }
  }
  FirebaseAuth.instance.userChanges().listen((user) {
    // ignore: unnecessary_null_comparison
    if (user == null) {
      if (kDebugMode) {
        print('User is currently signed out!');
      }
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SplitView(
                menu: DraweNavigation(),
                content: ElencoOspitiGenerali(),
                key: null,
              )));
      if (kDebugMode) {
        print('Login success');
      }
    }
  });
}

singUp(
    {required TextEditingController password_1,
    required TextEditingController password_2,
    required TextEditingController email,
    context}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  if (password_1.text != password_2.text) {
    await alert(context, "Le password non coincidono");
  } else {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: email.text, password: password_1.text)
          .then((value) async {
        var user = FirebaseAuth.instance.currentUser;

        await FirebaseFirestore.instance
            .collection("users")
            .doc(user?.uid)
            .set({
          'email': email.text,
          'password': password_1.text,
        });
      });
      if (kDebugMode) {
        print("Signed Up");
      }
      login(email: email, password: password_1);
    } catch (e) {
      /**  if (e.code == 'weak-password') {
        await alert(context, "Le password non rispetta i criteri di sicurezza");
      } else if (e.code == 'email-already-in-use') {
        await alert(context, "Questa mail é gia utilizzata");
      }*/
    }
  }
}

signInWithGoogle() async {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  try {
    // ignore: unused_local_variable
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    rethrow;
  }
}

// ignore: non_ant_identifier_names, non_constant_identifier_names
login_with_facebook() {}
