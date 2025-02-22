import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hotelmanagement/components/AlertDialog.dart';
import 'package:hotelmanagement/components/generalfunctions.dart';
import 'package:hotelmanagement/screen/AddScreen/add_booking_screen.dart';
import 'package:hotelmanagement/screen/EditScreen/edit_booking_screen.dart';
import 'package:hotelmanagement/screen/responsive/splitview.dart';

import 'list_customer.dart';

class ListBooking extends StatefulWidget {
  const ListBooking({super.key});
  @override
  State<ListBooking> createState() => _ListBookingState();
}

class _ListBookingState extends State<ListBooking> {
  String cognomePrenotazione = "";
  double priceForDay=1;
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
              .collection('Date')
              .doc(user?.uid)
              .collection("booking")
              .snapshots(),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot docSnap = snapshots.data!.docs[index];
                    return Slidable(
                      key: ObjectKey(docSnap.data()),
                      startActionPane: ActionPane(
                        motion: const BehindMotion(),
                        dismissible: DismissiblePane(
                          onDismissed: () async {
                            await alertDelete(
                                context,
                                "Sei sicuro di cancellare questa prenotazione",
                                user,
                                docSnap,
                                FirebaseFirestore.instance
                                    .collection('Date')
                                    .doc(user?.uid)
                                    .collection("booking")
                                    .doc(docSnap.id)
                                    .delete());
                          },
                        ),
                        children: [
                          SlidableAction(
                            onPressed: (direction) async {
                              await alertDelete(
                                  context,
                                  "Sei sicuro di cancellare questa prenotazione",
                                  user,
                                  docSnap,
                                  FirebaseFirestore.instance
                                      .collection('Date')
                                      .doc(user?.uid)
                                      .collection("booking")
                                      .doc(docSnap.id)
                                      .delete());
                              //update page after delete
                              // ignore: use_build_context_synchronously
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
                                var priceCtrl = TextEditingController();
                                var floorCtrl = TextEditingController();
                                var endDateCtrl = TextEditingController();
                                var startDateCtrl = TextEditingController();

                                priceCtrl.text = docSnap["Price"].toString();
                                floorCtrl.text = docSnap["Floor"];
                                endDateCtrl.text = docSnap["endDate"];
                                startDateCtrl.text = docSnap["startDate"];
                                // Calculate the difference in daysù
                                DateTime startDate =
                                    DateTime.parse(startDateCtrl.text);
                                DateTime endDate =
                                    DateTime.parse(endDateCtrl.text);
                                int days = endDate.difference(startDate).inDays;
                                priceForDay = docSnap["Price"] / days;
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditBooking(
                                          bookingcode: docSnap["bookingCode"],
                                          endDate: endDateCtrl,
                                          startDate: startDateCtrl,
                                          floor: floorCtrl,
                                          price: priceCtrl,
                                          cognomePrenotazione:
                                              docSnap["CognomePrenotazione"],
                                          nomePrenotazione:
                                              docSnap["NomePrenotazione"],
                                          nPeople: docSnap["Npeople"],
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
                                // ignore: prefer_interpolation_to_compose_strings
                                Text(
                                    // ignore: prefer_interpolation_to_compose_strings
                                    "${"Name: " + docSnap["NomePrenotazione"]} " +
                                        docSnap["CognomePrenotazione"]),
                              ],
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.person),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ListCustomer(bookingCode: docSnap.id)));
                            },
                          ),
                        ),
                        textCard(docSnap, "Floor:", "Floor"),
                        textCard(docSnap, "Start Date:", "startDate"),
                        textCard(docSnap, "End Date:", "endDate"),
                        textCard(docSnap, "Number of People: ", "Npeople"),
                        textCard(docSnap, "Price Soggiorno: ", "Price", "€"),
                        textCard2(
                            "Price per Day: ", priceForDay.toString(), "€"),
                      ])),
                    );
                  });
            } else {
              if (kDebugMode) {
                print("Date non trovati");
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
