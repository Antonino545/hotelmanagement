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

class AggiungiPrenotazione extends StatefulWidget {
  const AggiungiPrenotazione({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AggiungiPrenotazioneState createState() => _AggiungiPrenotazioneState();
}

class _AggiungiPrenotazioneState extends State<AggiungiPrenotazione> {
  var cognomePrenotazioneController = TextEditingController();
  var nomePrenotazioneController = TextEditingController();
  var numeroOspitiController = TextEditingController();
  var numeroTelfonoController = TextEditingController();
  var prezzoController = TextEditingController();
  var pianocontroller = TextEditingController();

  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final DateFormat nomeFormatter = DateFormat('MM/yyyy');

  DateTime dataInzio = DateTime.now();
  DateTime dataFine = DateTime.now();
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
              inputInt(TextInputType.number, "Prezzo soggiorno", false,
                  prezzoController),
              inputInt(TextInputType.number, " Numero Di Telefono", false,
                  numeroTelfonoController),
              inputText(TextInputType.text, "Piano", false, pianocontroller),
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
                      if (prezzoController.text.isEmpty) {
                        alert(context, parola = "Prezzo non inserito");
                        return;
                      }
                      // ignore: unnecessary_null_comparison
                      if (dataFine == null) {
                        alert(context, parola = "Data Fine non inserita");
                        return;
                      }
                      // ignore: unnecessary_null_comparison
                      if (dataInzio == null) {
                        alert(context, parola = "Data Inizio non inserita");
                        return;
                      }
                      if (pianocontroller.text.isEmpty) {
                        alert(context, parola = "Piano non inserito");
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
                              builder: (context) => AggiungiOspitiScreen(
                                  bookingcode: bookingCode.toString())));
                        }
                      }
                      numeroOspitiController.clear();
                      prezzoController.clear();
                      numeroTelfonoController.clear();
                      pianocontroller.clear();
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
          elevation: 20,
          contentPadding: const EdgeInsets.all(5),
          content: SizedBox(
            height: 300,
            width: 250,
            child: Scaffold(
              body: Column(
                children: [
                  SfDateRangePicker(
                    selectionMode: DateRangePickerSelectionMode.range,
                    onSelectionChanged: selectionChanged,
                    initialSelectedDate: DateTime.now(),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                child: const Text('Okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
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
        dataFine = args.value.endDate;
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
        .collection('Dati')
        .doc(user?.uid)
        .collection("prenotazioni")
        .doc(bookingCode.toString())
        .set({
      'bookingCode': bookingCode,
      'CognomePrenotazione': cognomePrenotazioneController.text,
      'NomePrenotazione': nomePrenotazioneController.text,
      'DataDiInizio': formatter.format(dataInzio),
      'DataFine': formatter.format(dataFine),
      'NPersone': int.parse(numeroOspitiController.text),
      'Prezzo': int.parse(prezzoController.text),
      'Piano': pianocontroller.text,
    });
  }
}
