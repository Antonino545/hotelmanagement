// split_view.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:hotelmanagement/screen/impostazione.dart';
import 'package:hotelmanagement/screen/responsive/responsive.dart';

import '../ListScreen/finance.dart';
import '../ListScreen/list_booking.dart';
import '../LoginScreen/welcome_screen.dart';

class SplitView extends StatefulWidget {
  const SplitView({Key? key}) : super(key: key);

  @override
  State<SplitView> createState() => _SplitViewState();
}

class _SplitViewState extends State<SplitView> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    ListBooking(),
    Finance(),
    Impostazioni(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final screenWidth = MediaQuery.of(context).size.width;
    if (isTab(context) || isDesktop(context)) {
      // widescreen: menu on the left, content on the right
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Row(
          children: [
            NavigationDrawer(
              onDestinationSelected: _onItemTapped,
              selectedIndex: _selectedIndex,
              //list view

              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const DrawerHeader(
                  //Drawer Parte Alta
                  child: Text(
                    "Hotel \nManagement", //testo Che si mostra nel Drawer
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const NavigationDrawerDestination(
                  icon: Icon(Icons.person),
                  label: Text('Ospiti'),
                ),
                const NavigationDrawerDestination(
                  icon: Icon(Icons.euro),
                  label: Text('Finanza'),
                ),
                const NavigationDrawerDestination(
                  icon: Icon(Icons.settings),
                  label: Text('Impostazioni'),
                ),
              ],
            ),
            Expanded(flex: 2, child: _widgetOptions.elementAt(_selectedIndex)),
          ],
        ),
      );
    } else {
      // narrow screen: show content, menu inside drawer

      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Ospiti',
            ),
            NavigationDestination(
              icon: Icon(Icons.euro),
              label: 'Finanza',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings),
              label: 'Impostazioni',
            ),
          ],
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
        ),
      );
    }
  }
}
