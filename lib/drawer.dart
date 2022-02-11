import 'package:flutter/material.dart';
import 'package:hotelmanagement/Screen/aggiungi_prenotazione_screen.dart';
import 'package:hotelmanagement/Screen/AggiungiSpeseScreen.dart';
import 'package:hotelmanagement/Screen/elenco_ospiti_attuali.dart';
import 'package:hotelmanagement/Screen/elenco_ospiti_generale.dart';
import 'package:page_transition/page_transition.dart';

import 'Screen/elenco_spese.dart';

class DraweNavigation extends StatefulWidget {
  @override
  _DraweNavigationState createState() => _DraweNavigationState();
}

class _DraweNavigationState extends State<DraweNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          //list view
          children: [
            const DrawerHeader(
              //Drawer Parte Alta
              child: Text(
                "Hotel \nManagement", //testo Che si mostra nel Drawer
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              //listTitle dove abbiamo il collegamento ad Aggiungi Ospiti
              title: const Text("Aggiungi Ospiti"),
              leading: const Icon(Icons.person_add),
              onTap: () => () => Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.leftToRight,
                      child: AggiungiPrenotazione())),
            ),
            ListTile(
              //listTitle dove abbiamo il collegamento ad Aggiungi Spese
              title: const Text("Aggiungi Spese"),
              leading: const Icon(Icons.add),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      AggiungiSpeseScreen())), //abbiamo il collegamento ad Aggiungi Spese
            ),
            ListTile(
              //listTitle dove abbiamo il collegamento ad Elenco Ospiti Generali
              title: const Text("Elenco Ospiti Generale"),
              leading: const Icon(Icons.list),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ElencoOspitiGenerali())), // abbiamo il collegamento ad Elenco Ospiti Generali
            ),
            ListTile(
              //listTitle dove abbiamo il collegamento ad Elenco Ospiti Attuali
              title: const Text("Elenco Ospiti Attuali"),
              leading: const Icon(Icons.list),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ElencoOspitiAttuali())), // abbiamo il collegamento ad Elenco Ospiti Attuali
            ),
            ListTile(
              //listTitle dove abbiamo il collegamento ad Finanze
              title: const Text("Finanze"),
              leading: const Icon(Icons.euro),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ElencoOspitiAttuali())), //abbiamo il collegamento ad Finanze
            ),
          ],
        ),
      ),
    );
  }
}
