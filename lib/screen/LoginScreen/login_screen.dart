// ignore: file_names
// ignore_for_file: prefer__ructors_in_immutables, prefer__ructors

import 'package:flutter/material.dart';
import 'package:hotelmanagement/screen/LoginScreen/sing_up_screen.dart';
import 'package:hotelmanagement/components/input.dart';
import 'package:hotelmanagement/components/login.dart';

import '../../drawer.dart';
import '../responsive/splitview.dart';
import '../ElencoScreen/elenco_ospiti_generale.dart';

// ignore: camel_case_types
class login_screen extends StatefulWidget {
  login_screen({Key? key}) : super(key: key);

  @override
  _login_screen_mobileState createState() => _login_screen_mobileState();
}

// ignore: camel_case_types
class _login_screen_mobileState extends State<login_screen> {
  @override
  Widget build(BuildContext context) {
    String box = "0";
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
              // ignore: prefer__literals_to_create_immutables
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
                  inputText(TextInputType.emailAddress, " Email", false, email),
                  inputText(TextInputType.visiblePassword, " Password", true,
                      password),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 50,
                        width: 500.0,
                        child: OutlinedButton(
                          onPressed: () {
                            login(
                                context: context,
                                box: box,
                                email: email,
                                password: password);
                          },
                          child: Text(
                            "Accedi",
                          ),
                          style: OutlinedButton.styleFrom(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
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
                        "Non hai un account?",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ElencoOspitiGenerali())),
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
}
