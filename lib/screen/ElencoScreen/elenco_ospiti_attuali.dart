import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/drawer.dart';
import 'package:hotelmanagement/screen/ElencoScreen/elenco_ospiti.dart';
import 'package:intl/intl.dart';

import '../responsive/pageScaffol.dart';

class ElencoOspitiAttuali extends StatefulWidget {
  ElencoOspitiAttuali({Key? key}) : super(key: key);

  @override
  _ElencoOspitiAttualiState createState() => _ElencoOspitiAttualiState();
}

class _ElencoOspitiAttualiState extends State<ElencoOspitiAttuali> {
  var user = FirebaseAuth.instance.currentUser;

  final DateFormat formatter = DateFormat('MM');
  final DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return PageScaffold(
        title: "Hotel Management",
        body: Scaffold(
          body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user?.uid)
                  .collection("prenotazioni")
                  .snapshots(),
              builder: (context, snapshots) {
                if (snapshots.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshots.data!.docs.length,
                      // ignore: missing_return
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot =
                            snapshots.data!.docs[index];
                        // ignore: non_ant_identifier_names
                        DateTime Data =
                            DateTime.parse(documentSnapshot["DataDiInizio"]);
                        if (formatter.format(Data) == formatter.format(now)) {
                          return Card(
                              elevation: 4,
                              margin: EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(children: [
                                ListTile(
                                  title: Padding(
                                    padding: EdgeInsets.all(8.0),
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
                                  subtitle: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        Text("Piano: " +
                                            documentSnapshot["Piano"]
                                                .toString()),
                                      ],
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.person),
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
                                  padding: EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Text("Data di inizio soggiorno: " +
                                          documentSnapshot["DataDiInizio"]
                                              .toString()),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Text("Data di Fine soggiorno: " +
                                          documentSnapshot["DataFine"]
                                              .toString()),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Text("Nummero di persone: " +
                                          documentSnapshot["NPersone"]
                                              .toString()),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
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
                                  padding: EdgeInsets.all(15.0),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 25,
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ]));
                        } else {
                          return Align(
                            alignment: FractionalOffset.center,
                            child: CircularProgressIndicator(),
                          );
                        }
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ));
  }
}
