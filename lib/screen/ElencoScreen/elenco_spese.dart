import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/drawer.dart';
import 'package:hotelmanagement/screen/AggiungiScreen/AggiungiSpeseScreen.dart';

// ignore: must_be_immutable
class ElencoSpese extends StatefulWidget {
  const ElencoSpese({Key? key}) : super(key: key);

  // ignore: non_ant_identifier_names, non_constant_identifier_names

  @override
  _ElencoSpeseState createState() => _ElencoSpeseState();
}

class _ElencoSpeseState extends State<ElencoSpese> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text("Hotel Management"),
        automaticallyImplyLeading: false,
      ),
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Dati')
              .doc(user?.uid)
              .collection("Spese")
              .snapshots(),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                        snapshots.data!.docs[index];
                    return Dismissible(
                      background: Card(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(Icons.delete),
                            ],
                          ),
                          color: Colors.red),
                      key: ObjectKey(documentSnapshot.data()),
                      onDismissed: (direction) {
                        try {
                          FirebaseFirestore.instance
                              .collection('Dati')
                              .doc(user?.uid)
                              .collection("Spese")
                              .doc(documentSnapshot.id)
                              .delete();
                        } catch (e) {
                          if (kDebugMode) {
                            print(e);
                          }
                        }
                      },
                      child: Card(
                          child: Column(children: [
                        ListTile(
                          title: Text("Nome Spesa: " +
                              documentSnapshot["NomeSpesa"].toString()),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Wrap(
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
                      ])),
                    );
                  });
            } else {
              return const Align(
                alignment: FractionalOffset.center,
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AggiungiSpeseScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
