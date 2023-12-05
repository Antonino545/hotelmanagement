// ignore_for_file: prefer__ructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/components/login.dart';
import '/components/input.dart';
import 'login_screen.dart';

FirebaseAuth auth = FirebaseAuth.instance;

// ignore: camel_case_types
class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  var isObscure = false;
  var isObscure2 = false;
  var password_1 = TextEditingController();
  var password_2 = TextEditingController();
  var email = TextEditingController();
  @override
  Widget build(BuildContext context) {



    return Scaffold(
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
              const Text(
                "Crea Account",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Crea il tuo nuovo account",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    inputText(
                        TextInputType.emailAddress, "Email", false, email),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: 500,
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                            suffixIcon: Padding(
                                padding:
                                const EdgeInsetsDirectional.only(end: 12.0),
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isObscure = !isObscure;
                                      });
                                    },
                                    icon: Icon(isObscure
                                        ? Icons.visibility : Icons.visibility_off))),
                            labelText: "Password",
                            hintText: "Inserisci la password",
                            border: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                          ),
                          obscureText: isObscure,
                          controller: password_1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: 500,
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                            suffixIcon: Padding(
                                padding:
                                const EdgeInsetsDirectional.only(end: 12.0),
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isObscure2 = !isObscure2;
                                      });
                                    },
                                    icon: Icon(isObscure2
                                        ? Icons.visibility
                                        : Icons.visibility_off))),
                            labelText: "Password",
                            hintText: "Inserisci la password",
                            border: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                          ),
                          obscureText: isObscure2,
                          controller: password_2,
                        ),
                      ),
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
                            singUp(
                                email: email,
                                password_1: password_1,
                                password_2: password_2);
                          },
                          child: const Text(
                            "Crea Account",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Hai un account?",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const Login())),
                          child: const Text(
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
              ),

            ],
          ),
        ),
      ),
    );
  }
}


