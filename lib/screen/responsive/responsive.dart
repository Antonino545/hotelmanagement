import 'package:flutter/material.dart';

//create a function to check the screen size
bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 650;
bool isTab(BuildContext context) =>
    MediaQuery.of(context).size.width < 1300 &&
    MediaQuery.of(context).size.width >= 650;
bool isDesktop(BuildContext context) =>
    MediaQuery.of(context).size.width >= 1300;
