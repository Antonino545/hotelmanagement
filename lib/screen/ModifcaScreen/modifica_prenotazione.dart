// ignore_for_file: must_be_immutable


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/components/generalfunctions.dart';

import '../../components/input.dart';
import '../ElencoScreen/elenco_ospiti.dart';

class ModificaPrenotazione extends StatefulWidget {
  String cognomePrenotazione;
  String nomePrenotazione;
  TextEditingController dataInizio;
  TextEditingController dataFine;
  int bookingcode;
  TextEditingController prezzo;
  int numeroPersone;
  TextEditingController piano;
  ModificaPrenotazione({
    Key? key,
    required this.bookingcode,
    required this.cognomePrenotazione,
    required this.dataFine,
    required this.numeroPersone,
    required this.dataInizio,
    required this.prezzo,
    required this.nomePrenotazione,
    required this.piano,
  }) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _ModificaPrenotazioneState createState() => _ModificaPrenotazioneState();
}

class _ModificaPrenotazioneState extends State<ModificaPrenotazione> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hotel Management"),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Card(
              child: Column(children: [
            ListTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ignore: prefer_interpolation_to_compose_strings
                    Text("Nome e cognome prenotazione:" +
                        widget.nomePrenotazione +
                        " " +
                        widget.cognomePrenotazione),
                  ],
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ElencoOspiti(
                            bookingCode: widget.bookingcode.toString(),
                          )));
                },
              ),
            ),
            inputTextCard(TextInputType.text, "Piano:", widget.piano),
            inputTextCard(TextInputType.datetime, "Data di inizio soggiorno:",
                widget.dataInizio),
            inputTextCard(TextInputType.datetime, "Data di fine soggiorno:",
                widget.dataFine),
            intCard("Numero di persone: ", widget.numeroPersone),
            inputTextCard(TextInputType.datetime, "Prezzo", widget.prezzo),
          ])),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            updatePrenotazione();
            Navigator.pop(context);
          },
          child: const Icon(Icons.done)),
    );
  }

  updatePrenotazione() {
    User? user = FirebaseAuth.instance.currentUser;
    if (kDebugMode) {
      print(widget.bookingcode);
    }
    FirebaseFirestore.instance
        .collection('Dati')
        .doc(user?.uid)
        .collection("prenotazioni")
        .doc(widget.bookingcode.toString())
        .set({
      'bookingCode': widget.bookingcode,
      'CognomePrenotazione': widget.cognomePrenotazione,
      'NomePrenotazione': widget.nomePrenotazione,
      'DataDiInizio': widget.dataFine.text,
      'DataFine': widget.dataFine.text,
      'NPersone': widget.numeroPersone,
      'Prezzo': widget.prezzo.text,
      'Piano': widget.piano.text,
    });
  }
}
