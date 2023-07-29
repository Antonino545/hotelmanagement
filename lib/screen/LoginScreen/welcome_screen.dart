import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/screen/loginScreen/sing_up_screen.dart';
import 'package:hotelmanagement/screen/responsive/responsive.dart';
import '../../components/login.dart';
import '/components/buttons.dart';
import 'login_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: camel_case_types
class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WelcomeState createState() => _WelcomeState();
}

// ignore: camel_case_types
class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Row(
            children: [
              if (isDesktop(context) || isTab(context))
                Expanded(
                  child: SvgPicture.asset(
                    "assets/login.svg",
                    height: size.height * 0.7,
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: !isMobile(context) ? 40 : 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Benvenuto \nIn Hotel Management\n",
                          style: TextStyle(
                            fontSize: isDesktop(context) ? 50 : 30,
                            fontWeight: FontWeight.w800,
                          )),
                      if (isMobile(context))
                        SvgPicture.asset(
                          "assets/login.svg",
                          height: size.height * 0.3,
                        ),
                      buttonPageTransition(
                          text: "Accedi",
                          onpressed: const Login(),
                          context: context),
                      buttonPageTransition(
                          text: "Crea un Account",
                          onpressed: const SingUp(),
                          context: context),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(onPressed:() {
                            if (kDebugMode) {
                              print("Google");
                            }
                            if (isMobile(context))
                              {
                                signInWithGoogleIosAndroid();
                              }
                            else
                              {signInWithGoogle();
                              }
                          },
                              icon:Image.asset("assets/google.png",height: 30,)
                          ),
                          IconButton(onPressed:() {
                            if (kDebugMode) {
                              print("Google");
                            }
                            if (isMobile(context))
                            {
                              signInWithFacebookIosAndroid();
                            }
                            else
                            {signInWithFacebook();
                            }
                          },
                              icon:Image.asset("assets/Facebook.png",height: 30,)
                          ),
                        ],
                      ),

                      Wrap(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(" Termini e Condizioni"),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text("Privacy Policy"),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
