import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hotelmanagement/components/generalfunctions.dart';
import 'package:hotelmanagement/screen/AddScreen/add_booking_screen.dart';
import 'package:hotelmanagement/screen/EditScreen/edit_booking_screen.dart';
import 'package:hotelmanagement/screen/responsive/splitview.dart';

import 'list_customer.dart';

class ListBooking extends StatefulWidget {
  const ListBooking({Key? key}) : super(key: key);
  @override
  _ListBookingState createState() => _ListBookingState();
}

class _ListBookingState extends State<ListBooking> {
  String cognomePrenotazione = "";

  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
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
              .collection("prenotazioni")
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
                                "Sei sicuro di cancellare questa prenotazione",
                                user,
                                documentSnapshot);
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const SplitView()));
                          },
                        ),

                        // All actions are defined in the children parameter.
                        children: [
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            onPressed: (direction) async {
                              await alertTwoButton(
                                  context,
                                  "Sei sicuro di cancellare questa prenotazione",
                                  user,
                                  documentSnapshot);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const SplitView()));
                            },
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            icon: Icons.delete,
                          ),
                          SlidableAction(
                              onPressed: (direction) {
                                var prezzoController = TextEditingController();
                                var pianocontroller = TextEditingController();
                                var datafineController =
                                    TextEditingController();
                                var datainiziocontroller =
                                    TextEditingController();

                                prezzoController.text =
                                    documentSnapshot["Prezzo"].toString();
                                pianocontroller.text =
                                    documentSnapshot["Piano"];
                                datafineController.text =
                                    documentSnapshot["DataFine"];
                                datainiziocontroller.text =
                                    documentSnapshot["DataDiInizio"];
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditBooking(
                                          bookingcode:
                                              documentSnapshot["bookingCode"],
                                          dataFine: datafineController,
                                          dataInizio: datainiziocontroller,
                                          piano: pianocontroller,
                                          prezzo: prezzoController,
                                          cognomePrenotazione: documentSnapshot[
                                              "CognomePrenotazione"],
                                          nomePrenotazione: documentSnapshot[
                                              "NomePrenotazione"],
                                          numeroPersone:
                                              documentSnapshot["NPersone"],
                                        )));
                              },
                              borderRadius: BorderRadius.circular(10),
                              icon: Icons.edit),
                        ],
                      ),
                      child: Card(
                          child: Column(children: [
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Nome e cognome Prenotazione: " +
                                    documentSnapshot["NomePrenotazione"] +
                                    " " +
                                    documentSnapshot["CognomePrenotazione"]),
                              ],
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.person),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ListCustomer(
                                        bookingCode:
                                            documentSnapshot["bookingCode"]
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
                      ])),
                    );
                  });
            } else {
              if (kDebugMode) {
                print("dati non trovati");
              }
              return const Align(
                alignment: FractionalOffset.center,
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddBooking()));
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
                      .collection("prenotazioni")
                      .doc(documentSnapshot.id)
                      .delete();
                } catch (e) {
                  if (kDebugMode) {
                    print(e);
                  }
                }
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
                          .collection("prenotazioni")
                          .doc(documentSnapshot.id)
                          .delete();
                    } catch (e) {
                      if (kDebugMode) {
                        print(e);
                      }
                    }
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
