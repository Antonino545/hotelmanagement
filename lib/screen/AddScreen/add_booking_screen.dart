import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hotelmanagement/components/AlertDialog.dart';
import 'package:hotelmanagement/components/input.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'add_customer_screen.dart';

class AddBooking extends StatefulWidget {
  const AddBooking({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddBookingState createState() => _AddBookingState();
}

class _AddBookingState extends State<AddBooking> {
  var cognomePrenotazioneController = TextEditingController();
  var nomePrenotazioneController = TextEditingController();
  var numeroOspitiController = TextEditingController();
  var numeroTelfonoController = TextEditingController();
  var priceCtrl = TextEditingController();
  var floorCtrl = TextEditingController();

  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final DateFormat nomeFormatter = DateFormat('MM/yyyy');

  DateTime dataInzio = DateTime.now();
  DateTime endDate = DateTime.now();
  String cognomeNonValido = "Cognome non valido";
  String parola = "";
  int bookingCode = 0;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ignore: prefer__ructors
              const Text(
                "Aggiungi Ospiti",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              inputText(TextInputType.text, "Nome Prenotazione", false,
                  nomePrenotazioneController),
              inputText(TextInputType.text, "Cognome Prenotazione", false,
                  cognomePrenotazioneController),
              inputInt(TextInputType.number, "Numero Ospiti", false,
                  numeroOspitiController),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: OutlinedButton(
                  onPressed: () {
                    alertDataRange(
                        context, "inserire data di inizio e fine soggiorno");
                  },
                  child: const Text("inserire date del soggiorno"),
                ),
              ),
              inputInt(
                  TextInputType.number, "Costo soggiorno", false, priceCtrl),
              inputInt(TextInputType.number, " Numero Di Telefono", false,
                  numeroTelfonoController),
              inputText(TextInputType.text, "Piano o Numero di stanza", false,
                  floorCtrl),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () async {
                      if (cognomePrenotazioneController.text.isEmpty) {
                        alert(context,
                            parola = "Cognome Prenotazione non inserito");
                        return;
                      }
                      if (numeroTelfonoController.text.isEmpty) {
                        alert(context,
                            parola = "Numero di Telefono non inserito");
                        return;
                      }
                      if (numeroOspitiController.text.isEmpty) {
                        alert(context, parola = "Numero Ospiti non inserito");
                        return;
                      }
                      if (priceCtrl.text.isEmpty) {
                        alert(context, parola = "Costo soggiorno non inserito");
                        return;
                      }
                      // ignore: unnecessary_null_comparison
                      if (endDate == null) {
                        alert(context, parola = "Data Fine non inserita");
                        return;
                      }
                      // ignore: unnecessary_null_comparison
                      if (dataInzio == null) {
                        alert(context, parola = "Data Inizio non inserita");
                        return;
                      }
                      if (floorCtrl.text.isEmpty) {
                        alert(context,
                            parola = "Piano o N di stanza non inserito");
                        return;
                      }

                      {
                        User? user = FirebaseAuth.instance.currentUser;
                        var collection =
                            FirebaseFirestore.instance.collection('users');
                        var docSnapshot = await collection.doc(user?.uid).get();
                        if (kDebugMode) {
                          print(user?.uid);
                        }
                        if (docSnapshot.exists) {
                          Map<String, dynamic>? data = docSnapshot.data();
                          bookingCode = data?['bookingCode'];
                        }

                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user?.uid)
                            .update({"bookingCode": FieldValue.increment(1)});
                        FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('users')
                                .doc(user?.uid)
                                .get(),
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return const Text("Something went wrong");
                              }

                              var data =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              return bookingCode = data["bookingCode"];
                            });
                        await addDataFamigli();

                        for (int i = 0;
                            i < int.parse(numeroOspitiController.text);
                            i++) {
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddCustomer(
                                  bookingcode: bookingCode.toString())));
                        }
                      }
                    
                      numeroOspitiController.clear();
                      priceCtrl.clear();
                      numeroTelfonoController.clear();
                      floorCtrl.clear();
                      numeroOspitiController.clear();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> alertDataRange(BuildContext context, box) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: MediaQuery.of(context).size.width / 1.5,
            width: MediaQuery.of(context).size.width / 2,
            child: SfDateRangePicker(
              onSelectionChanged: selectionChanged,
              selectionMode: DateRangePickerSelectionMode.range,
              initialSelectedRange: PickerDateRange(
                  DateTime.now().subtract(const Duration(days: 4)),
                  DateTime.now().add(const Duration(days: 3))),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    try {
      setState(() {
        dataInzio = args.value.startDate;
        endDate = args.value.endDate;
      });
      // ignore: empty_catches
    } catch (e) {}
  }

  addDataFamigli() {
    if (kDebugMode) {
      print(bookingCode.toString());
    }
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('Date')
        .doc(user?.uid)
        .collection("booking")
        .doc(bookingCode.toString())
        .set({
      'bookingCode': bookingCode,
      'CognomePrenotazione': cognomePrenotazioneController.text,
      'NomePrenotazione': nomePrenotazioneController.text,
      'DataDiInizio': formatter.format(dataInzio),
      'endDate': formatter.format(endDate),
      'Npeople': int.parse(numeroOspitiController.text),
      'Price': int.parse(priceCtrl.text),
      'Floor': floorCtrl.text,
    });
  }
}
