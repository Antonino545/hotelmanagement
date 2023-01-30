import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/components/AlertDialog.dart';

import 'package:hotelmanagement/screen/ListScreen/list_booking.dart';

import '../../components/generalfunctions.dart';

//list of card with all the customer of a booking

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
    var user = FirebaseAuth.instance.currentUser; //get the user
    return Scaffold(
      appBar: AppBar(title: const Text("Hotel Management")),
      body: StreamBuilder<QuerySnapshot>(
          //stream of the customer of the booking
          stream: FirebaseFirestore.instance
              .collection('Dati')
              .doc(user?.uid)
              .collection("booking")
              .doc(widget.bookingCode)
              .collection("Ospiti")
              .snapshots(),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              //check if the stream has data
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot docSnap = snapshots.data!.docs[index];

                    return Dismissible(
                      key: ObjectKey(docSnap.data()),
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
                        //delete the customer
                        try {
                          FirebaseFirestore.instance
                              .collection('Dati')
                              .doc(user?.uid)
                              .collection("booking")
                              .doc(widget.bookingCode)
                              .collection("Ospiti")
                              .doc(docSnap.id)
                              .delete();
                        } catch (e) {
                          //if there is an error show it
                          alert(context, e.toString());
                        }
                      },
                      //show the customer data
                      child: Card(
                          child: Column(
                        children: [
                          ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Nome Ospite: ' + docSnap["Nome"]),
                                Text("Cognome Ospite: " + docSnap["Cognome"]),
                              ],
                            ),
                          ),
                          textCard(
                              docSnap, "Codice Fiscale: ", "Codice Fiscale"),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                if (docSnap["Maggiorenne"] ==
                                    true) //check if the customer is major
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
              //if the stream has no data show a loading indicator
              return const Align(
                alignment: FractionalOffset.center,
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
