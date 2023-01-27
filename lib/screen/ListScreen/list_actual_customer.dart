// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hotelmanagement/screen/ListScreen/list_customer.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../../components/generalfunctions.dart';

class ElencoOspitiAttuali extends StatefulWidget {
  const ElencoOspitiAttuali({Key? key}) : super(key: key);

  @override
  _ElencoOspitiAttualiState createState() => _ElencoOspitiAttualiState();
}

class _ElencoOspitiAttualiState extends State<ElencoOspitiAttuali> {
  var user = FirebaseAuth.instance.currentUser;

  final DateFormat formatter = DateFormat('MM');
  final DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hotel Management"),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
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
                  // ignore: missing_return
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                        snapshots.data!.docs[index];
                    // ignore: non_ant_identifier_names, non_constant_identifier_names
                    DateTime Data =
                        DateTime.parse(documentSnapshot["DataDiInizio"]);
                    if (formatter.format(Data) == formatter.format(now)) {
                      return Slidable(
                          child: Column(children: [
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    // ignore: prefer_interpolation_to_compose_strings
                                    "${"Nome e cognome Prenotazione: " + documentSnapshot["NomePrenotazione"]} " +
                                        documentSnapshot[
                                            "CognomePrenotazione"]),
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
                        textCard(documentSnapshot, "Piano:", "Piano"),
                        textCard(documentSnapshot, "Data di inizio soggiorno:",
                            "DataDiInizio"),
                        textCard(documentSnapshot, "Data di Fine soggiorno:",
                            "DataFine"),
                        textCard(documentSnapshot, "Numero di persone: ",
                            "NPersone"),
                        textCard(
                            documentSnapshot, "Prezzo Soggiorno: ", "Prezzo"),
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
                    } else {
                      return const Align(
                        alignment: FractionalOffset.center,
                        child: CircularProgressIndicator(),
                      );
                    }
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
