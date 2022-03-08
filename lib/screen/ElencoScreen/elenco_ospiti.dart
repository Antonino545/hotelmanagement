import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:hotelmanagement/screen/ElencoScreen/elenco_ospiti_generale.dart';

import '../../components/generalfunctions.dart';
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
  ElencoOspitiGenerali f2 = const ElencoOspitiGenerali();

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(title: Text("Hotel Management")),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Dati')
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
                      return Card(
                          child: Column(
                        children: [
                          ListTile(
                            trailing: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  try {
                                    FirebaseFirestore.instance
                                        .collection('Dati')
                                        .doc(user?.uid)
                                        .collection("prenotazioni")
                                        .doc(widget.cognomePrenotazione)
                                        .collection("Ospiti")
                                        .doc(documentSnapshot.id)
                                        .delete();
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                              ),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Nome Ospite: " + documentSnapshot["Nome"]),
                                Text("Cognome Ospite: " +
                                    documentSnapshot["Cognome"]),
                              ],
                            ),
                          ),
                          textCard(documentSnapshot, "Codice Fiscale: ",
                              "Codice Fiscale"),
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
                    } else {
                      return const Align(
                        alignment: FractionalOffset.center,
                        child: CircularProgressIndicator(),
                      );
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
