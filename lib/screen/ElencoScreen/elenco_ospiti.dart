import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:hotelmanagement/screen/ElencoScreen/elenco_ospiti_generale.dart';

// ignore: must_be_immutable
class ElencoOspiti extends StatefulWidget {
  String cognomePrenotazione;
  ElencoOspiti({
    Key key,
    this.cognomePrenotazione,
  }) : super(key: key);
  @override
  _ElencoOspiti createState() => _ElencoOspiti();
}

class _ElencoOspiti extends State<ElencoOspiti> {
  ElencoOspitiGenerali f2 = ElencoOspitiGenerali();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hotel Management")),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Ospiti').snapshots(),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshots.data.docs.length,
                  // ignore: missing_return
                  itemBuilder: (context, index) {
                    if (kDebugMode) {
                      print("ciao " + widget.cognomePrenotazione);
                    }
                    DocumentSnapshot documentSnapshot =
                        snapshots.data.docs[index];
                    if (documentSnapshot["CognomePrenotazione"] ==
                        widget.cognomePrenotazione) {
                      return Card(
                          elevation: 4,
                          margin: const EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                    "Nome Ospite: " + documentSnapshot["Nome"]),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Text("Cognome Ospite: " +
                                        documentSnapshot["Cognome"]),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Text("Codice Fiscale: " +
                                        documentSnapshot["Codice Fiscale"]),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    if (documentSnapshot["Maggiorenne"] == true)
                                      const Text("Maggiorenne")
                                    else
                                      const Text("Minorenne")
                                  ],
                                ),
                              ),
                            ],
                          ));
                    }
                  });
            } else {
              return const Align(
                alignment: FractionalOffset.center,
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
