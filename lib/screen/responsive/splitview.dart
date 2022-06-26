// split_view.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/screen/ElencoScreen/elenco_ospiti_generale.dart';
import 'package:hotelmanagement/screen/ElencoScreen/finanze.dart';
import 'package:hotelmanagement/screen/impostazione.dart';
import 'package:hotelmanagement/screen/responsive/responsive.dart';

import '../LoginScreen/welcome_screen.dart';

class SplitView extends StatefulWidget {
  const SplitView({Key? key}) : super(key: key);

  @override
  State<SplitView> createState() => _SplitViewState();
}

class _SplitViewState extends State<SplitView> {
  int _selectedIndex = 0;
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
                      child: Text(
                        "Hotel \nManagement", //testo Che si mostra nel Drawer
                        style: TextStyle(
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
                            builder: (context) => const Welcome()))
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
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Ospiti',
            ),
            NavigationDestination(
              icon: Icon(Icons.euro),
              label: 'Finanaza',
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
