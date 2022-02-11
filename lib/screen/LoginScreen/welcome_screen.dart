import 'package:flutter/material.dart';
import 'package:hotelmanagement/screen/LoginScreen/sing_up_screen.dart';
import 'package:hotelmanagement/screen/responsive/responsive.dart';
import '../components/buttons.dart';
import '../components/login.dart';
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
            mainAxisAlignment: MainAxisAlignment.center,
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
                              button_pageTransition(
                                  text: "Accedi",
                                  onpressed: login_screen(),
                                  context: context),
                              button_pageTransition(
                                  text: "Crea un Account",
                                  onpressed: singup(),
                                  context: context),
                              const SizedBox(
                                height: 10,
                              ),
                              button_ico(
                                text: "Accedi con Google",
                                icon: "google.png",
                                onpressed: login_with_google(),
                                context: context,
                              ),
                              button_ico(
                                text: "Accedi con Facebook",
                                icon: "facebook.png",
                                onpressed: login_with_facebook(),
                                context: context,
                              ),
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
