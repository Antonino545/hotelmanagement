// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/components/generalfunctions.dart';
import 'package:hotelmanagement/screen/AggiungiScreen/aggiungi_prenotazione_screen.dart';
import 'package:hotelmanagement/screen/responsive/pageScaffol.dart';

import 'elenco_ospiti.dart';

class ElencoOspitiGenerali extends StatefulWidget {
  const ElencoOspitiGenerali({Key? key}) : super(key: key);
  @override
  _ElencoOspitiGeneraliState createState() => _ElencoOspitiGeneraliState();
}

class _ElencoOspitiGeneraliState extends State<ElencoOspitiGenerali> {
  String cognomePrenotazione = "";

  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: "Hotel Management",
      body: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder<QuerySnapshot>(
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
                                elevation: 4,
                                margin: const EdgeInsets.all(8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(children: [
                                  ListTile(
                                    title: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Nome e cognome Prenotazione: " +
                                              documentSnapshot[
                                                  "NomePrenotazione"] +
                                              " " +
                                              documentSnapshot[
                                                  "CognomePrenotazione"]),
                                        ],
                                      ),
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.person),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ElencoOspiti(
                                                      cognomePrenotazione:
                                                          documentSnapshot[
                                                                  "CognomePrenotazione"]
                                                              .toString(),
                                                    )));
                                      },
                                    ),
                                  ),
                                  textCard(documentSnapshot, "Piano:", "Piano"),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        Text("Piano: " +
                                            documentSnapshot["Piano"]
                                                .toString()),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        Text("Data di inizio soggiorno: " +
                                            documentSnapshot["DataDiInizio"]
                                                .toString()),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        Text("Data di Fine soggiorno: " +
                                            documentSnapshot["DataFine"]
                                                .toString()),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        Text("Numero di persone: " +
                                            documentSnapshot["NPersone"]
                                                .toString()),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Prezzo Soggiorno: " +
                                              documentSnapshot["Prezzo"]
                                                  .toString() +
                                              "€",
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 25,
                                      ),
                                      onPressed: () {
                                        try {
                                          FirebaseFirestore.instance
                                              .collection('Dati')
                                              .doc(user?.uid)
                                              .collection("prenotazioni")
                                              .doc(documentSnapshot.id)
                                              .delete();
                                          int ospitiindex = 0;
                                          DocumentSnapshot ospiticounter =
                                              snapshots.data!.docs[ospitiindex];
                                          print(ospiticounter);
                                          /*FirebaseFirestore.instance
                                              .collection('Dati')
                                              .doc(user?.uid)
                                              .collection("prenotazioni")
                                              .doc(cognomePrenotazione)
                                              .collection("Ospiti")
                                              .doc(documentSnapshot.id)
                                              .delete();*/
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                    ),
                                  ),
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
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AggiungiPrenotazione()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
