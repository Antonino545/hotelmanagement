import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/screen/components/input.dart';

class AggiungiOspitiScreen extends StatefulWidget {
  final String cognomeprenotazione;

  const AggiungiOspitiScreen({Key key, this.cognomeprenotazione})
      : super(key: key);

  @override
  _AggiungiOspitiScreenState createState() => _AggiungiOspitiScreenState();
}

class _AggiungiOspitiScreenState extends State<AggiungiOspitiScreen> {
  //aggiungi i Dati nella Raccolta Ospiti in Firebase

//creazioni variabili
  var NomeController = TextEditingController();
  var CognomeController = TextEditingController();
  var CodiceFiscaleController = TextEditingController();
  bool Maggiorenni = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Text(
            "Aggiungi Ospiti",
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          input_text(TextInputType.text, " Nome", false, NomeController),
          input_text(TextInputType.text, " Cognome", false, CognomeController),
          input_text(TextInputType.text, " Codice Fiscale", false,
              CodiceFiscaleController),
          Padding(
            // Texfield Maggiorenne
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text(
                  "Maggiorenne",
                  style: TextStyle(fontSize: 20),
                ),
                Switch(
                  value: Maggiorenni,
                  onChanged: (value) {
                    setState(() {
                      Maggiorenni = value;
                    });
                  },
                ),
              ],
            ),
          ),
          IconButton(
              //bottone in cui ti porta alla schermata precedente
              icon: const Icon(Icons.person_add),
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

  addDataOspiti() {
    User user = FirebaseAuth.instance.currentUser;
    Future<DocumentReference> collectionReference = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection("prenotazioni")
        .doc("widget.CognomePrenotazione")
        .collection("Ospiti")
        .add({
      'Codice Fiscale': CodiceFiscaleController.text,
      'Cognome': CognomeController.text,
      'Nome': NomeController.text,
      'CognomePrenotazione': widget.cognomeprenotazione,
      'Maggiorenne': Maggiorenni,
    });
  }
}
