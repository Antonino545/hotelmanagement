import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:hotelmanagement/screen/ElencoScreen/elenco_ospiti_generale.dart';

import '../responsive/pageScaffol.dart';

// ignore: must_be_immutable
class ElencoOspiti extends StatefulWidget {
  String cognomePrenotazione;
  ElencoOspiti({
    Key? key,
    required this.cognomePrenotazione,
  }) : super(key: key);
  @override
  _ElencoOspiti createState() => _ElencoOspiti();
}

class _ElencoOspiti extends State<ElencoOspiti> {
  ElencoOspitiGenerali f2 = ElencoOspitiGenerali();

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(title: Text("Hotel Management")),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(user?.uid)
              .collection("prenotazioni")
              .doc(widget.cognomePrenotazione)
              .collection("Ospiti")
              .snapshots(),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                        snapshots.data!.docs[index];
                    if (documentSnapshot["CognomePrenotazione"] ==
                        widget.cognomePrenotazione) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Card(
                            elevation: 4,
                            margin: EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text("Nome Ospite: " +
                                      documentSnapshot["Nome"]),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Text("Cognome Ospite: " +
                                          documentSnapshot["Cognome"]),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Text("Codice Fiscale: " +
                                          documentSnapshot["Codice Fiscale"]),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      if (documentSnapshot["Maggiorenne"] ==
                                          true)
                                        Text("Maggiorenne")
                                      else
                                        Text("Minorenne")
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      );
                    } else {
                      return Align(
                        alignment: FractionalOffset.center,
                        child: CircularProgressIndicator(),
                      );
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
