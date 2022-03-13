// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/app.dart';
import 'package:hotelmanagement/components/generalfunctions.dart';
import 'package:hotelmanagement/drawer.dart';
import 'package:hotelmanagement/screen/AggiungiScreen/aggiungi_prenotazione_screen.dart';
import 'package:hotelmanagement/screen/responsive/splitview.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Hotel Management"),
        automaticallyImplyLeading: false,
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
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
                          return Dismissible(
                            onDismissed: (direction) {
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
                                if (kDebugMode) {
                                  print(ospiticounter);
                                }
                                /*FirebaseFirestore.instance
                                                .collection('Dati')
                                                .doc(user?.uid)
                                                .collection("prenotazioni")
                                                .doc(cognomePrenotazione)
                                                .collection("Ospiti")
                                                .doc(documentSnapshot.id)
                                                .delete();*/
                              } catch (e) {
                                if (kDebugMode) {
                                  print(e);
                                }
                              }
                            },
                            key: ObjectKey(documentSnapshot.data()),
                            background: Card(
                              color: Colors.red,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.delete,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                            child: Card(
                                child: Column(children: [
                              ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Nome e cognome Prenotazione: " +
                                          documentSnapshot["NomePrenotazione"] +
                                          " " +
                                          documentSnapshot[
                                              "CognomePrenotazione"]),
                                    ],
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.person),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => ElencoOspiti(
                                                  cognomePrenotazione:
                                                      documentSnapshot[
                                                              "CognomePrenotazione"]
                                                          .toString(),
                                                )));
                                  },
                                ),
                              ),
                              textCard(documentSnapshot, "Piano:", "Piano"),
                              textCard(documentSnapshot,
                                  "Data di inizio soggiorno:", "DataDiInizio"),
                              textCard(documentSnapshot,
                                  "Data di Fine soggiorno:", "DataFine"),
                              textCard(documentSnapshot, "Numero di persone: ",
                                  "NPersone"),
                              textCard(documentSnapshot, "Prezzo Soggiorno: ",
                                  "Prezzo"),
                            ])),
                          );
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
              builder: (context) => const AggiungiPrenotazione()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
