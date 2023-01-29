import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:hotelmanagement/screen/ListScreen/list_booking.dart';

import '../../components/generalfunctions.dart';

// ignore: must_be_immutable

class ListCustomer extends StatefulWidget {
  String bookingCode;
  ListCustomer({
    Key? key,
    required this.bookingCode,
  }) : super(key: key);

  @override
  State<ListCustomer> createState() => _ListCustomerState();
}

class _ListCustomerState extends State<ListCustomer> {
  ListBooking f2 = const ListBooking();

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(title: const Text("Hotel Management")),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Dati')
              .doc(user?.uid)
              .collection("prenotazioni")
              .doc(widget.bookingCode)
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

                    return Dismissible(
                      key: ObjectKey(documentSnapshot.data()),
                      background: Card(
                        color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Icon(
                              Icons.delete,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                      onDismissed: (orienation) {
                        try {
                          FirebaseFirestore.instance
                              .collection('Dati')
                              .doc(user?.uid)
                              .collection("prenotazioni")
                              .doc(widget.bookingCode)
                              .collection("Ospiti")
                              .doc(documentSnapshot.id)
                              .delete();
                        } catch (e) {
                          if (kDebugMode) {
                            print(e);
                          }
                        }
                      },
                      child: Card(
                          child: Column(
                        children: [
                          ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Nome Ospite: ' + documentSnapshot["Nome"]),
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
                      )),
                    );
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
