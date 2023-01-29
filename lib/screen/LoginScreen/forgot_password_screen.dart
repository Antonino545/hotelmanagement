// ignore: file_names
// ignore_for_file: prefer__ructors_in_immutables, prefer__ructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotelmanagement/components/AlertDialog.dart';
import 'package:hotelmanagement/components/input.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String box = "0";
  var password = TextEditingController();
  var email = TextEditingController();
  // final bool _isobscure = true;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
          if (kDebugMode) {
            print("Enter");
          }
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: const [
                Text(
                  "Recupero dell'account",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Inserisci la mail dell'account",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  inputText(
                    TextInputType.emailAddress,
                    " Email",
                    false,
                    email,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 50,
                          width: 500.0,
                          child: OutlinedButton(
                            onPressed: () async {
                              alert(context,
                                  "É stata inviata una mail a ${email.text}");
                              await _auth
                                  .sendPasswordResetEmail(email: email.text)
                                  // ignore: avoid_print
                                  .catchError((e) => print(e));
                            },
                            style: OutlinedButton.styleFrom(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    width: 10.0,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                            child: const Text(
                              "Recupero dell'account",
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
