// ignore: file_names
// ignore_for_file: prefer__ructors_in_immutables, prefer__ructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotelmanagement/components/input.dart';
import 'package:hotelmanagement/components/login.dart';
import 'package:hotelmanagement/screen/LoginScreen/sing_up_screen.dart';

// ignore: camel_case_types
class login_screen extends StatelessWidget {
  const login_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String box = "0";
    var password = TextEditingController();
    var email = TextEditingController();
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
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  // ignore: prefer__literals_to_create_immutables
                  children: const [
                    Text(
                      "Accedi",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                      inputText(
                        TextInputType.visiblePassword,
                        " Password",
                        true,
                        password,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
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
                              child: const Text(
                                "Accedi",
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
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Non hai un account?",
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const singup_screen())),
                            child: const Text(
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
        ),
      ),
    );
  }
}
