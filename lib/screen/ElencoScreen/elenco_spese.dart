import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/drawer.dart';

// ignore: must_be_immutable
class ElencoSpese extends StatefulWidget {
  // ignore: non_constant_identifier_names
  String CognomePrenotazione;

  ElencoSpese({Key key}) : super(key: key);
  @override
  _ElencoSpeseState createState() => _ElencoSpeseState();
}

class _ElencoSpeseState extends State<ElencoSpese> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Hotel Management",
      )),
      drawer: const DraweNavigation(),
      resizeToAvoidBottomInset: false,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Spese').snapshots(),
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
                            title: Text("Nome Spesa: " +
                                documentSnapshot["NomeSpesa"].toString()),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Text("Descrizione: " +
                                    documentSnapshot["DescrizioneSpesa"]
                                        .toString()),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Text("Costo Spesa: " +
                                    documentSnapshot["CostoSpesa"].toString()),
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
                        ]));
                  });
            } else {
              return const Align(
                alignment: FractionalOffset.center,
                child: const CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
