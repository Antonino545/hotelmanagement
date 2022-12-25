import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hotelmanagement/screen/aggiungiscreen/aggiungi_speseScreen.dart';

// ignore: must_be_immutable
class Finanze extends StatefulWidget {
  const Finanze({Key? key}) : super(key: key);

  // ignore: non_ant_identifier_names, non_constant_identifier_names

  @override
  _FinanzeState createState() => _FinanzeState();
}

class _FinanzeState extends State<Finanze> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hotel Management"),
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
                    return Slidable(
                      key: ObjectKey(documentSnapshot.data()),
                      startActionPane: ActionPane(
                        // A motion is a widget used to control how the pane animates.
                        motion: const BehindMotion(),

                        // A pane can dismiss the Slidable.
                        dismissible: DismissiblePane(
                          onDismissed: () async {
                            await alertTwoButton(
                                context,
                                "Sei sicuro di cancellare questa Spesa",
                                user,
                                documentSnapshot);
                          },
                        ),

                        // All actions are defined in the children parameter.
                        children: [
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            onPressed: (direction) async {
                              await alertTwoButton(
                                  context,
                                  "Sei sicuro di cancellare questa spesa",
                                  user,
                                  documentSnapshot);
                            },
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                          ),
                          SlidableAction(
                              onPressed: (direction) {
                                alertTwoButton(
                                    context,
                                    "Sei sicuro di cancellare questa spesa",
                                    user,
                                    documentSnapshot);
                              },
                              foregroundColor: Colors.white,
                              icon: Icons.edit),
                        ],
                      ),
                      child: Card(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                      documentSnapshot["CostoSpesa"]
                                          .toString()),
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

Future<void> alertTwoButton(BuildContext context, box, user, documentSnapshot) {
  if (Platform.isIOS) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Text(box),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('Si'),
              onPressed: () {
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
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  } else {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(box),
          actions: <Widget>[
            Row(
              children: [
                TextButton(
                  child: const Text('Si'),
                  onPressed: () {
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
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                    child: const Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ],
            ),
          ],
        );
      },
    );
  }
}
