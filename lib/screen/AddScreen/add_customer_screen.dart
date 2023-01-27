import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/components/input.dart';

class AggiungiOspitiScreen extends StatefulWidget {
  final String bookingcode;

  const AggiungiOspitiScreen({Key? key, required this.bookingcode})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AggiungiOspitiScreenState createState() => _AggiungiOspitiScreenState();
}

class _AggiungiOspitiScreenState extends State<AggiungiOspitiScreen> {
  //aggiungi i Dati nella Raccolta Ospiti in Firebase

//creazioni variabili
  var nomeController = TextEditingController();
  var cognomeController = TextEditingController();
  var codiceFiscaleController = TextEditingController();
  bool maggiorenni = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          const Text(
            "Aggiungi Ospiti",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          inputText(TextInputType.text, " Nome", false, nomeController),
          inputText(TextInputType.text, " Cognome", false, cognomeController),
          inputText(TextInputType.text, " Codice Fiscale", false,
              codiceFiscaleController),
          Padding(
            // Texfield Maggiorenne
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                children: [
                  const Text(
                    "Maggiorenne",
                    style: TextStyle(fontSize: 20),
                  ),
                  Switch.adaptive(
                    value: maggiorenni,
                    onChanged: (value) {
                      setState(() {
                        maggiorenni = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          IconButton(
              //bottone in cui ti porta alla schermata precedente
              icon: const Icon(Icons.person_add),
              onPressed: () {
                if (nomeController.text.isNotEmpty &&
                    cognomeController.text.isNotEmpty) {
                  addDataOspiti();
                  Navigator.pop(context);
                }
              }),
        ],
      ),
    );
  }

  addDataOspiti() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('Dati')
        .doc(user?.uid)
        .collection("prenotazioni")
        .doc(widget.bookingcode)
        .collection("Ospiti")
        .add({
      'Codice Fiscale': codiceFiscaleController.text,
      'Cognome': cognomeController.text,
      'Nome': nomeController.text,
      'Maggiorenne': maggiorenni,
    });
  }
}
