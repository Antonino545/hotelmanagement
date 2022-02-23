// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/screen/components/login.dart';

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
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      width: 500.0,
                      child: OutlinedButton(
                        onPressed: () async {
                          Singup(password_1, password_2, email, context);
                        },
                        child: Text(
                          "Crea Account",
                        ),
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
                      ),
                    )),
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
