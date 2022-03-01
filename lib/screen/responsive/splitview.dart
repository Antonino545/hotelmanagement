// split_view.dart
import 'package:flutter/material.dart';
import 'package:hotelmanagement/screen/responsive/responsive.dart';

class SplitView extends StatelessWidget {
  SplitView({
    Key? key,
    // menu and content are now configurable
    required this.menu,
    required this.content,
    // these values are now configurable with sensible default values
    this.menuWidth = 240,
  }) : super(key: key);
  final Widget menu;
  final Widget content;
  final double menuWidth;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (isTab(context) || isDesktop(context)) {
      // widescreen: menu on the left, content on the right
      return Row(
        children: [
          SizedBox(
            child: menu,
          ),
          Container(width: 0.5, color: Colors.black),
          Expanded(flex: 4, child: content),
        ],
      );
    } else {
      // narrow screen: show content, menu inside drawer
      return Scaffold(
        body: content,
        drawer: SizedBox(
          width: menuWidth,
          child: Drawer(
            child: menu,
          ),
        ),
      );
    }
  }
}
