import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hotelmanagement/screen/LoginScreen/sing_up_screen.dart';
import 'package:hotelmanagement/screen/responsive/responsive.dart';
import '../components/buttons.dart';
import '../components/login.dart';
import 'login_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: camel_case_types
class welcome extends StatefulWidget {
  const welcome({Key key}) : super(key: key);

  @override
  _welcomeState createState() => _welcomeState();
}

// ignore: camel_case_types
class _welcomeState extends State<welcome> {
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
                    "asset/Login.svg",
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
                      if (isMobile(context))
                        SvgPicture.asset(
                          "asset/login.svg",
                          height: size.height * 0.3,
                        ),
                      Text("Benvenuto \nIn Hotel Management\n",
                          style: TextStyle(
                            fontSize: isDesktop(context) ? 50 : 30,
                            fontWeight: FontWeight.w800,
                          )),
                      button_pageTransition(
                          text: "Accedi",
                          onpressed: login_screen(),
                          context: context),
                      button_pageTransition(
                          text: "Crea un Account",
                          onpressed: singup_screen(),
                          context: context),
                      button_ico(
                        text: "Accedi con Google",
                        icon: AntDesign.google,
                        onpressed: signInWithGoogle(),
                        context: context,
                      ),
                      button_ico(
                        text: "Accedi con Facebook",
                        icon: FontAwesome5Brands.facebook,
                        onpressed: login_with_facebook(),
                        context: context,
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
