// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/drawer.dart';
import 'package:hotelmanagement/screen/responsive/responsive.dart';

import 'elenco_ospiti.dart';

class ElencoOspitiGenerali extends StatefulWidget {
  ElencoOspitiGenerali({Key key}) : super(key: key);
  @override
  _ElencoOspitiGeneraliState createState() => _ElencoOspitiGeneraliState();
}

class _ElencoOspitiGeneraliState extends State<ElencoOspitiGenerali> {
  String cognomePrenotazione;

  User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Hotel Management",
      )),
      drawer: const DraweNavigation(),
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(right: !isMobile(context) ? 50 : 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .collection("prenotazioni")
                      .snapshots(),
                  builder: (context, snapshots) {
                    if (snapshots.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshots.data.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot documentSnapshot =
                                snapshots.data.docs[index];
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
                                        children: [
                                          Text("Nome Prenotazione: " +
                                              documentSnapshot[
                                                  "NomePrenotazione"]),
                                          Text("Cognome Prenotazione: " +
                                              documentSnapshot[
                                                  "CognomePrenotazione"]),
                                        ],
                                      ),
                                    ),
                                    subtitle: Text(
                                        "Piano: " + documentSnapshot["Piano"]),
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
                                        Text("Nummero di persone: " +
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
                                      onPressed: () {},
                                    ),
                                  ),
                                ]));
                          });
                    } else {
                      print("dati non trovati");
                      return const Align(
                        alignment: FractionalOffset.center,
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
