// split_view.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/screen/ElencoScreen/elenco_ospiti_generale.dart';
import 'package:hotelmanagement/screen/ElencoScreen/fianze.dart';
import 'package:hotelmanagement/screen/impostazione.dart';
import 'package:hotelmanagement/screen/responsive/responsive.dart';

import '../LoginScreen/welcome_screen.dart';

class SplitView extends StatefulWidget {
  @override
  State<SplitView> createState() => _SplitViewState();
}

class _SplitViewState extends State<SplitView> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    ElencoOspitiGenerali(),
    Finanze(),
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
      return SafeArea(
        child: Row(
          children: [
            SizedBox(
              child: Drawer(
                child: ListView(
                  //list view
                  children: [
                    const DrawerHeader(
                      //Drawer Parte Alta
                      child: const Text(
                        "Hotel \nManagement", //testo Che si mostra nel Drawer
                        style: const TextStyle(
                          color: Colors.teal,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListTile(
                        title: const Text("Ospiti"),
                        leading: const Icon(Icons.person),
                        onTap: () => (_onItemTapped(0))),
                    ListTile(
                        //listTitle dove abbiamo il collegamento ad Finanze
                        title: const Text("Finanze"),
                        leading: const Icon(Icons.euro),
                        onTap: () => (_onItemTapped(1))),
                    ListTile(
                        //listTitle dove abbiamo il collegamento ad Finanze
                        title: const Text("Impostazione"),
                        leading: const Icon(Icons.settings),
                        onTap: () => (_onItemTapped(2))),
                    ListTile(
                      //listTitle dove abbiamo il collegamento ad Finanze
                      title: const Text("Logout"),
                      leading: const Icon(Icons.logout),
                      onTap: () async => {
                        await FirebaseAuth.instance.signOut(),
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const welcome()))
                      }, //abbiamo il collegamento ad Finanze
                    ),
                  ],
                ),
              ),
            ),
            Container(width: 0.5, color: Colors.black),
            Expanded(flex: 4, child: _widgetOptions.elementAt(_selectedIndex)),
          ],
        ),
      );
    } else {
      // narrow screen: show content, menu inside drawer

      return Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Ospiti',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.euro),
              label: 'Finanaza',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Impostazioni',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      );
    }
  }
}
