import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/drawer.dart';
import 'package:hotelmanagement/Screen/elenco_ospiti_generale.dart';

class ElencoOspiti extends StatefulWidget {
  String CognomePrenotazione;
  ElencoOspiti({
    this.CognomePrenotazione,
  });
  @override
  _ElencoOspiti createState() => _ElencoOspiti();
}

class _ElencoOspiti extends State<ElencoOspiti> {
  ElencoOspitiGenerali f2 = ElencoOspitiGenerali();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Hotel Management",
        style: TextStyle(color: Colors.white),
      )),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Ospiti').snapshots(),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshots.data.docs.length,
                  itemBuilder: (context, index) {
                    print("ciao " + widget.CognomePrenotazione);
                    DocumentSnapshot documentSnapshot =
                        snapshots.data.docs[index];
                    if (documentSnapshot["CognomePrenotazione"] ==
                        widget.CognomePrenotazione) {
                      return Card(
                          elevation: 4,
                          margin: EdgeInsets.all(8),
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
                                      Text("Maggiorenne")
                                    else
                                      Text("Minorenne")
                                  ],
                                ),
                              ),
                            ],
                          ));
                    }
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
