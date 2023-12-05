// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/components/generalfunctions.dart';

import '../../components/input.dart';
import '../ListScreen/list_customer.dart';

class EditBooking extends StatefulWidget {
  String cognomePrenotazione;
  String nomePrenotazione;
  TextEditingController startDate;
  TextEditingController endDate;
  int bookingcode;
  TextEditingController price;
  int nPeople;
  TextEditingController floor;
  EditBooking({
    super.key,
    required this.bookingcode,
    required this.cognomePrenotazione,
    required this.endDate,
    required this.nPeople,
    required this.startDate,
    required this.price,
    required this.nomePrenotazione,
    required this.floor,
  });
  @override
  // ignore: library_private_types_in_public_api
  _EditBookingState createState() => _EditBookingState();
}

class _EditBookingState extends State<EditBooking> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hotel Management"),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Card(
              child: Column(children: [
            ListTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ignore: prefer_interpolation_to_compose_strings
                    Text("Nome e cognome prenotazione:" +
                        widget.nomePrenotazione +
                        " " +
                        widget.cognomePrenotazione),
                  ],
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ListCustomer(
                            bookingCode: widget.bookingcode.toString(),
                          )));
                },
              ),
            ),
            inputTextCard(TextInputType.text, "Piano:", widget.floor),
            inputTextCard(TextInputType.datetime, "Data di inizio soggiorno:",
                widget.startDate),
            inputTextCard(TextInputType.datetime, "Data di fine soggiorno:",
                widget.endDate),
            intCard("Numero di persone: ", widget.nPeople),
            inputTextCard(TextInputType.datetime, "Price", widget.price),
          ])),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            updatePrenotazione();
            Navigator.pop(context);
          },
          child: const Icon(Icons.done)),
    );
  }

  updatePrenotazione() {
    User? user = FirebaseAuth.instance.currentUser;
    if (kDebugMode) {
      print(widget.bookingcode);
    }
    FirebaseFirestore.instance
        .collection('Date')
        .doc(user?.uid)
        .collection("booking")
        .doc(widget.bookingcode.toString())
        .set({
      'bookingCode': widget.bookingcode,
      'CognomePrenotazione': widget.cognomePrenotazione,
      'NomePrenotazione': widget.nomePrenotazione,
      'DataDiInizio': widget.endDate.text,
      'endDate': widget.endDate.text,
      'Npeople': widget.nPeople,
      'Price': widget.price.text,
      'Floor': widget.floor.text,
    });
  }
}
