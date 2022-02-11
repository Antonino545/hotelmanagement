import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/drawer.dart';

import 'elenco_ospiti.dart';

class ElencoOspitiGenerali extends StatefulWidget {
  String CognomePrenotazione;
  @override
  _ElencoOspitiGeneraliState createState() => _ElencoOspitiGeneraliState();
}

class _ElencoOspitiGeneraliState extends State<ElencoOspitiGenerali> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Hotel Management",
        style: TextStyle(color: Colors.white),
      )),
      drawer: DraweNavigation(),
      resizeToAvoidBottomInset: false,
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('Prenotazione').snapshots(),
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
                        margin: EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(children: [
                          ListTile(
                            title: Text("Cognome Prenotazione: " +
                                documentSnapshot["CognomePrenotazione"]),
                            subtitle:
                                Text("Piano: " + documentSnapshot["Piano"]),
                            trailing: IconButton(
                              icon: Icon(Icons.person),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ElencoOspiti(
                                          CognomePrenotazione: documentSnapshot[
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
                                    documentSnapshot["DataFine"].toString()),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Text("Nummero di persone: " +
                                    documentSnapshot["NPersone"].toString()),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Text("Prezzo Soggiorno: " +
                                    documentSnapshot["Prezzo"].toString() +
                                    "€"),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 25,
                            ),
                            onPressed: () {},
                          ),
                        ]));
                  });
            } else {
              return Align(
                alignment: FractionalOffset.center,
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
