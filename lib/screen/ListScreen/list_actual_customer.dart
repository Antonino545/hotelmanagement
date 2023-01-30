// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hotelmanagement/screen/ListScreen/list_customer.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../../components/generalfunctions.dart';

class ListActualCustomer extends StatefulWidget {
  const ListActualCustomer({Key? key}) : super(key: key);

  @override
  _ListActualCustomerState createState() => _ListActualCustomerState();
}

class _ListActualCustomerState extends State<ListActualCustomer> {
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
              .collection("booking")
              .snapshots(),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshots.data!.docs.length,
                  // ignore: missing_return
                  itemBuilder: (context, index) {
                    DocumentSnapshot docSnap = snapshots.data!.docs[index];
                    // ignore: non_ant_identifier_names, non_constant_identifier_names
                    DateTime Data = DateTime.parse(docSnap["DataDiInizio"]);
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
                                    "${"Nome e cognome Prenotazione: " + docSnap["NomePrenotazione"]} " +
                                        docSnap["CognomePrenotazione"]),
                              ],
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.person),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ListCustomer(
                                        bookingCode:
                                            docSnap["CognomePrenotazione"]
                                                .toString(),
                                      )));
                            },
                          ),
                        ),
                        textCard(docSnap, "Floor:", "Floor"),
                        textCard(
                            docSnap, "Data di inizio soggiorno:", "startDate"),
                        textCard(docSnap, "Data di Fine soggiorno:", "endDate"),
                        textCard(docSnap, "Numero di persone: ", "Npeople"),
                        textCard(docSnap, "Prezzo Soggiorno: ", "Price"),
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
