import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/components/AlertDialog.dart';
import 'package:hotelmanagement/components/input.dart';

class AddCustomer extends StatefulWidget {
  final String bookingcode;

  const AddCustomer({super.key, required this.bookingcode});

  @override
  AddCustomerState createState() => AddCustomerState();
}

class AddCustomerState extends State<AddCustomer> {
  //aggiungi i Date nella Raccolta Ospiti in Firebase

//creazioni variabili
  var nomeController = TextEditingController();
  var cognomeController = TextEditingController();
  var codiceFiscaleController = TextEditingController();
  bool maggiorenni = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Aggiungi Ospiti",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
// Chiamata corretta alla funzione inputText
            inputText(
              textInput: TextInputType.text,
              label: "Nome",
              controller: nomeController,
              obscureText: false,
              isNumeric: false,
            ),
            inputText(
              textInput: TextInputType.text,
              label: "Cognome",
              controller: cognomeController,
              obscureText: false,
              isNumeric: false,
            ),

            inputText(
              textInput: TextInputType.text,
              label: "Codice Fiscale",
              controller: codiceFiscaleController,
              obscureText: false,
              isNumeric: false,
            ),

            Padding(
              // Texfield Maggiorenne
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text(
                    "Maggiorenne",
                    style: TextStyle(fontSize: 20),
                  ),
                  Switch.adaptive(
                    value: maggiorenni,
                    onChanged: (value) {
                      setState(() {
                        maggiorenni = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            IconButton(
                //bottone in cui ti porta alla schermata precedente
                icon: const Icon(Icons.person_add),
                onPressed: () {
                  if (nomeController.text.isNotEmpty &&
                      cognomeController.text.isNotEmpty) {
                    addDataOspiti();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } else {
                    alert(context, "Insert i dati mancanti");
                  }
                }),
          ],
        ),
      ),
    );
  }

  addDataOspiti() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('Date')
        .doc(user?.uid)
        .collection("booking")
        .doc(widget.bookingcode)
        .collection("Ospiti")
        .add({
      'Codice Fiscale': codiceFiscaleController.text,
      'Cognome': cognomeController.text,
      'Nome': nomeController.text,
      'Maggiorenne': maggiorenni,
    });
  }
}
