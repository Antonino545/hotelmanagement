import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hotelmanagement/Screen/aggiungi_prenotazione_screen.dart';
import 'package:hotelmanagement/Drawer.dart';
import 'package:hotelmanagement/app.dart';

import 'components/imput.dart';

class AggiungiOspitiScreen extends StatefulWidget {
  final String CognomePrenotazione;

  const AggiungiOspitiScreen({Key key, this.CognomePrenotazione})
      : super(key: key);

  @override
  _AggiungiOspitiScreenState createState() => _AggiungiOspitiScreenState();
}

class _AggiungiOspitiScreenState extends State<AggiungiOspitiScreen> {
  //aggiungi i Dati nella Raccolta Ospiti in Firebase
  addDataOspiti() {
    Future<DocumentReference> collectionReference =
        FirebaseFirestore.instance.collection('Ospiti').add({
      'Codice Fiscale': CodiceFiscaleController.text,
      'Cognome': CognomeController.text,
      'Nome': NomeController.text,
      'CognomePrenotazione': widget.CognomePrenotazione,
      'Maggiorenne': Maggiorenni,
    });
  }

//creazioni variabili
  var NomeController = TextEditingController();
  var CognomeController = TextEditingController();
  var CodiceFiscaleController = TextEditingController();
  bool Maggiorenni = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(
        children: [
          Text(
            "Aggiungi Ospiti",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          imput_text("Inserire Nome", false, NomeController),

          Padding(
            // Texfield Cognome
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                labelText: "Cognome",
                hintText: "inserisci Cognome",
              ),
              controller: CognomeController,
            ),
          ),
          Padding(
            // Texfield CodiceFiscale
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                labelText: "Codice Fiscale",
                hintText: "inserisci Codice Fiscale",
              ),
              controller: CodiceFiscaleController,
            ),
          ),
          Padding(
            // Texfield Maggiorenne
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Maggiorenne",
                  style: TextStyle(fontSize: 20),
                ),
                Expanded(
                    child: Container(
                  height: 20,
                  width: 20,
                )),
                FlutterSwitch(
                  //switch
                  width: 100.0, //grandezza
                  height: 50.0,
                  valueFontSize: 20.0,
                  toggleSize: 45.0,
                  value: Maggiorenni,
                  borderRadius: 30.0,
                  padding: 8.0,
                  showOnOff: true,
                  onToggle: (val) {
                    //val e un boleano
                    setState(() {
                      Maggiorenni = val;
                      print(Maggiorenni);
                    });
                  },
                ),
              ],
            ),
          ),
          IconButton(
              //bottone in cui ti porta alla schermata precedente
              icon: Icon(Icons.person_add),
              onPressed: () {
                if (NomeController.text.length !=
                    0) if (CognomeController.text.length != 0) {
                  addDataOspiti();
                  Navigator.pop(context);
                }
              }),
        ],
      ),
    );
  }
}
