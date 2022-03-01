// ignore_for_file: unnecessary_const

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:hotelmanagement/screen/AggiungiScreen/AggiungiSpeseScreen.dart';
import 'package:hotelmanagement/screen/AggiungiScreen/aggiungi_prenotazione_screen.dart';
import 'package:hotelmanagement/screen/ElencoScreen/elenco_ospiti_attuali.dart';
import 'package:hotelmanagement/screen/ElencoScreen/elenco_ospiti_generale.dart';
import 'package:hotelmanagement/screen/ElencoScreen/elenco_spese.dart';
import 'package:hotelmanagement/screen/LoginScreen/welcome_screen.dart';
import 'package:hotelmanagement/screen/responsive/splitview.dart';

class DraweNavigation extends StatefulWidget {
  const DraweNavigation({Key? key}) : super(key: key);

  @override
  _DraweNavigationState createState() => _DraweNavigationState();
}

class _DraweNavigationState extends State<DraweNavigation> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            //listTitle dove abbiamo il collegamento ad Aggiungi Spese
            title: const Text("Aggiungi Ospiti"),
            leading: const Icon(Icons.add),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SplitView(
                    menu: DraweNavigation(),
                    content:
                        const AggiungiPrenotazione()))), //abbiamo il collegamento ad Aggiungi Spese
          ),
          ListTile(
              //listTitle dove abbiamo il collegamento ad Aggiungi Spese
              title: const Text("Aggiungi Spese"),
              leading: const Icon(Icons.add),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SplitView(
                      menu: DraweNavigation(),
                      content:
                          const AggiungiSpeseScreen()))) //abbiamo il collegamento ad Aggiungi Spese
              ),
          ListTile(
              //listTitle dove abbiamo il collegamento ad Elenco Ospiti Generali
              title: const Text("Elenco Ospiti Generale"),
              leading: const Icon(Icons.list),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SplitView(
                      menu: DraweNavigation(),
                      content:
                          const ElencoOspitiGenerali()))) //abbiamo  il collegamento ad Elenco Ospiti Generali
              ),
          ListTile(
              //listTitle dove abbiamo il collegamento ad Elenco Ospiti Attuali
              title: const Text("Elenco Ospiti Attuali"),
              leading: const Icon(Icons.list),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SplitView(
                      menu: DraweNavigation(),
                      content:
                          const ElencoOspitiAttuali()))) //abbiamo  // abbiamo il collegamento ad Elenco Ospiti Attuali
              ),
          ListTile(
            //listTitle dove abbiamo il collegamento ad Finanze
            title: const Text("Finanze"),
            leading: const Icon(Icons.euro),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SplitView(
                    menu: const DraweNavigation(),
                    content:
                        ElencoSpese()))), //abbiamo il collegamento ad Finanze
          ),
          ListTile(
            //listTitle dove abbiamo il collegamento ad Finanze
            title: const Text("Logout"),
            leading: const Icon(Icons.logout),
            onTap: () async => {
              await FirebaseAuth.instance.signOut(),
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const welcome()))
            }, //abbiamo il collegamento ad Finanze
          ),
        ],
      ),
    );
  }
}
