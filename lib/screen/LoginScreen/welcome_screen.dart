import 'package:flutter/material.dart';
import 'package:hotelmanagement/screen/LoginScreen/sing_up_screen.dart';
import 'package:hotelmanagement/screen/responsive/responsive.dart';
import 'login_screen.dart';

class welcome extends StatefulWidget {
  const welcome({Key key}) : super(key: key);

  @override
  _welcomeState createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Image(
                      image: const AssetImage("assets/login.png"),
                      height: size.height * 0.7,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Benvenuto \nIn Hotel Management\n",
                                style: TextStyle(
                                  fontSize: isDesktop(context) ? 50 : 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                )),
                          ])),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 50,
                                  width: 500.0,
                                  child: OutlinedButton(
                                    onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => login())),
                                    child: Text("Crea  Account"),
                                    style: OutlinedButton.styleFrom(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25,
                                      ),
                                      elevation: 20,
                                      backgroundColor: Colors.transparent,
                                      primary: Colors.white,
                                      side: BorderSide(color: Colors.white),
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 50,
                                  width: 500.0,
                                  child: OutlinedButton(
                                    onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => login())),
                                    child: Text("Accedi"),
                                    style: OutlinedButton.styleFrom(
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25,
                                      ),
                                      elevation: 20,
                                      backgroundColor: Colors.transparent,
                                      primary: Colors.white,
                                      side: BorderSide(color: Colors.white),
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 500.0,
                                  child: OutlinedButton.icon(
                                    onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => singup())),
                                    label: const Text("Login con Google"),
                                    icon: Image.asset(
                                      'assets/google.png',
                                      scale: 10,
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      elevation: 20,
                                      backgroundColor: Colors.blue,
                                      primary: Colors.white,
                                      side:
                                          const BorderSide(color: Colors.white),
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 500.0,
                                  child: OutlinedButton.icon(
                                    onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => singup())),
                                    label: const Text("Login con Facebook"),
                                    icon: Image.asset(
                                      'assets/facebook.png',
                                      scale: 10,
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      side:
                                          const BorderSide(color: Colors.white),
                                      primary: Colors.white,
                                      elevation: 20,
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

Widget button({text, icon, onpressed, context}) {
  Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 500.0,
        child: OutlinedButton.icon(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => onpressed)),
          label: Text(text),
          icon: Image.asset(
            'assets/' + icon,
            scale: 10,
          ),
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.blue,
            side: const BorderSide(color: Colors.white),
            primary: Colors.white,
            elevation: 20,
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(50)),
          ),
        ),
      ));
}
