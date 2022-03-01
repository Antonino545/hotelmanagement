import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:hotelmanagement/screen/AggiungiScreen/AggiungiSpeseScreen.dart';
import 'package:hotelmanagement/screen/AggiungiScreen/aggiungi_ospiti_screen.dart';
import 'package:hotelmanagement/screen/AggiungiScreen/aggiungi_prenotazione_screen.dart';
import 'package:hotelmanagement/screen/ElencoScreen/elenco_ospiti_attuali.dart';
import 'package:hotelmanagement/screen/ElencoScreen/elenco_ospiti_generale.dart';
import 'package:hotelmanagement/screen/ElencoScreen/elenco_spese.dart';
import 'package:hotelmanagement/screen/LoginScreen/welcome_screen.dart';
import 'package:hotelmanagement/screen/responsive/splitview.dart';

class DraweNavigation extends StatefulWidget {
  DraweNavigation({Key? key}) : super(key: key);

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
          DrawerHeader(
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
            //listTitle dove abbiamo il collegamento ad Aggiungi Spese
            title: Text("Aggiungi Ospiti"),
            leading: Icon(Icons.add),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SplitView(
                    menu: DraweNavigation(),
                    content:
                        AggiungiPrenotazione()))), //abbiamo il collegamento ad Aggiungi Spese
          ),
          ListTile(
              //listTitle dove abbiamo il collegamento ad Aggiungi Spese
              title: Text("Aggiungi Spese"),
              leading: Icon(Icons.add),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SplitView(
                      menu: DraweNavigation(),
                      content:
                          AggiungiSpeseScreen()))) //abbiamo il collegamento ad Aggiungi Spese
              ),
          ListTile(
              //listTitle dove abbiamo il collegamento ad Elenco Ospiti Generali
              title: Text("Elenco Ospiti Generale"),
              leading: Icon(Icons.list),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SplitView(
                      menu: DraweNavigation(),
                      content:
                          ElencoOspitiGenerali()))) //abbiamo  il collegamento ad Elenco Ospiti Generali
              ),
          ListTile(
              //listTitle dove abbiamo il collegamento ad Elenco Ospiti Attuali
              title: Text("Elenco Ospiti Attuali"),
              leading: Icon(Icons.list),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SplitView(
                      menu: DraweNavigation(),
                      content:
                          ElencoOspitiAttuali()))) //abbiamo  // abbiamo il collegamento ad Elenco Ospiti Attuali
              ),
          ListTile(
            //listTitle dove abbiamo il collegamento ad Finanze
            title: Text("Finanze"),
            leading: Icon(Icons.euro),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SplitView(
                    menu: DraweNavigation(),
                    content:
                        ElencoSpese()))), //abbiamo il collegamento ad Finanze
          ),
          ListTile(
            //listTitle dove abbiamo il collegamento ad Finanze
            title: Text("Logout"),
            leading: Icon(Icons.logout),
            onTap: () async => {
              await FirebaseAuth.instance.signOut(),
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => welcome()))
            }, //abbiamo il collegamento ad Finanze
          ),
        ],
      ),
    );
  }
}
