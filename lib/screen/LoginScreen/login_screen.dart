import 'package:flutter/material.dart';
import 'package:hotelmanagement/components/input.dart';
import 'package:hotelmanagement/components/login.dart';
import 'package:hotelmanagement/screen/LoginScreen/forgot_password_screen.dart';
import 'package:hotelmanagement/screen/LoginScreen/sing_up_screen.dart';

// ignore: camel_case_types
class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String box = "0";
  var password = TextEditingController();
  var email = TextEditingController();
  bool _isObscure = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Column(
            children: [
              Text(
                "Login",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
          Column(
            children: [
              inputText(
                textInput: TextInputType.emailAddress,
                label: "Email",
                controller: email,
                obscureText: false,
                isNumeric: false,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 500,
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                          padding: const EdgeInsetsDirectional.only(end: 12.0),
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                              icon: Icon(_isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                      labelText: "Password",
                      hintText: "Insert la password",
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    obscureText: _isObscure,
                    controller: password,
                  ),
                ),
              ),
            ],
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
                          onPressed: () {
                            loginEmail(
                                context: context,
                                box: box,
                                email: email,
                                password: password);
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
                            "Accedi",
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
                                builder: (context) => const ForgotPassword())),
                        child: const Text(
                          "Hai dimenticato la password?",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const SingUp())),
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
          ),
        ],
      ),
    );
  }
}
