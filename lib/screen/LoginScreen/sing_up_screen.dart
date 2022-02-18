// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/screen/components/buttons.dart';
import 'package:hotelmanagement/screen/components/login.dart';

import '../components/AlertDialog.dart';
import '../components/input.dart';
import 'login_screen.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class singup_screen extends StatelessWidget {
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
        padding: EdgeInsets.symmetric(horizontal: 40),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                  input_text(
                      TextInputType.emailAddress, " Email", false, email),
                  input_text(TextInputType.visiblePassword, " Password", true,
                      password_1),
                  input_text(TextInputType.visiblePassword, " Password", true,
                      password_2),
                ],
              ),
            ),
            Column(
              children: [
                MaterialButton(
                  minWidth: 200,
                  color: Colors.blue,
                  height: 60,
                  onPressed: () async {
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

                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(user.uid)
                              .set({
                            'uid': user.uid,
                            'email': email.text,
                            'password': password_1.text,
                          });
                        });
                        print("Signed Up");
                      } catch (e) {
                        if (e.code == 'weak-password') {
                          await Alert(context,
                              "Le password non rispetta i criteri di sicurezza");
                        } else if (e.code == 'email-already-in-use') {
                          await Alert(context, "Questa mail é gia utilizzata");
                        }
                      }
                    }
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
                          MaterialPageRoute(
                              builder: (context) => login_screen())),
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
          ],
        ),
      ),
    );
  }
}
