// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/components/generalfunctions.dart';

import '../../components/input.dart';
import '../ElencoScreen/elenco_ospiti.dart';

class ModificaPrenotazione extends StatefulWidget {
  String cognomePrenotazione;
  String nomePrenotazione;
  String dataInizio;
  String dataFine;
  int prezzo;
  int numeroPersone;
  String piano;
  ModificaPrenotazione({
    Key? key,
    required this.cognomePrenotazione,
    required this.dataFine,
    required this.numeroPersone,
    required this.dataInizio,
    required this.prezzo,
    required this.nomePrenotazione,
    required this.piano,
  }) : super(key: key);
  @override
  _ModificaPrenotazioneState createState() => _ModificaPrenotazioneState();
}

class _ModificaPrenotazioneState extends State<ModificaPrenotazione> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hotel Management"),
        automaticallyImplyLeading: false,
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Dati')
                .doc(user?.uid)
                .collection("prenotazioni")
                .snapshots(),
            builder: (context, snapshots) {
              if (snapshots.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot documentSnapshot =
                          snapshots.data!.docs[index];
                      return Card(
                          child: Column(children: [
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Nome e cognome Prenotazione: " +
                                    documentSnapshot["NomePrenotazione"] +
                                    " " +
                                    documentSnapshot["CognomePrenotazione"]),
                              ],
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.person),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ElencoOspiti(
                                        bookingCode: documentSnapshot[
                                                "CognomePrenotazione"]
                                            .toString(),
                                      )));
                            },
                          ),
                        ),
                        inputTextCard(
                            TextInputType.text, "Piano:", widget.piano),
                        inputTextCard(TextInputType.datetime,
                            "Data Di Inizio soggiorno:", widget.dataInizio),
                        inputTextCard(TextInputType.datetime,
                            "Data di Fine soggiorno:", widget.dataFine),
                        textCard(documentSnapshot, "Numero di persone: ",
                            "NPersone"),
                        inputTextCard(
                            TextInputType.datetime, "Prezzo", widget.prezzo),
                      ]));
                    });
              } else {
                if (kDebugMode) {
                  print("dati non trovati");
                }
                return const Align(
                  alignment: FractionalOffset.center,
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.done)),
    );
  }

  addDataFamigli() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('Dati')
        .doc(user?.uid)
        .collection("prenotazioni")
        .doc()
        .set({
      'CognomePrenotazione': widget.cognomePrenotazione,
      'NomePrenotazione': widget.nomePrenotazione,
      'DataDiInizio': widget.dataFine,
      'DataFine': widget.dataFine,
      'NPersone': widget.numeroPersone,
      'Prezzo': widget.prezzo,
      'Piano': widget.piano,
    });
  }
}

Future<void> alertTwoButton(BuildContext context, box, user, documentSnapshot) {
  if (Platform.isIOS) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Text(box),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('Si'),
              onPressed: () {
                try {
                  FirebaseFirestore.instance
                      .collection('Dati')
                      .doc(user?.uid)
                      .collection("prenotazioni")
                      .doc(documentSnapshot.id)
                      .delete();
                } catch (e) {
                  if (kDebugMode) {
                    print(e);
                  }
                }
              },
            ),
            CupertinoDialogAction(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  } else {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(box),
          actions: <Widget>[
            Row(
              children: [
                TextButton(
                  child: const Text('Si'),
                  onPressed: () {
                    try {
                      FirebaseFirestore.instance
                          .collection('Dati')
                          .doc(user?.uid)
                          .collection("prenotazioni")
                          .doc(documentSnapshot.id)
                          .delete();
                    } catch (e) {
                      if (kDebugMode) {
                        print(e);
                      }
                    }
                  },
                ),
                TextButton(
                    child: const Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ],
            ),
          ],
        );
      },
    );
  }
}
