import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/drawer.dart';
import 'package:hotelmanagement/screen/ElencoScreen/elenco_ospiti.dart';
import 'package:intl/intl.dart';

class ElencoOspitiAttuali extends StatefulWidget {
  const ElencoOspitiAttuali({Key key}) : super(key: key);

  @override
  _ElencoOspitiAttualiState createState() => _ElencoOspitiAttualiState();
}

class _ElencoOspitiAttualiState extends State<ElencoOspitiAttuali> {
  final DateFormat formatter = DateFormat('MM');
  final DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Hotel Management",
      )),
      drawer: const DraweNavigation(),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('Prenotazione').snapshots(),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshots.data.docs.length,
                  // ignore: missing_return
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                        snapshots.data.docs[index];
                    // ignore: non_constant_identifier_names
                    DateTime Data =
                        DateTime.parse(documentSnapshot["DataDiInizio"]);
                    if (formatter.format(Data) == formatter.format(now)) {
                      return Card(
                          elevation: 4,
                          margin: const EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text("Cognome Prenotazione: " +
                                    documentSnapshot["CognomePrenotazione"]),
                                subtitle:
                                    Text("Piano: " + documentSnapshot["Piano"]),
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
                                    Text("Prezzo Soggiorno: " +
                                        documentSnapshot["Prezzo"].toString() +
                                        "€"),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 25,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ));
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
