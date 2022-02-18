import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotelmanagement/Screen/components/AlertDialog.dart';
import 'package:hotelmanagement/screen/components/input.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/drawer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'aggiungi_ospiti_screen.dart';

class AggiungiPrenotazione extends StatefulWidget {
  @override
  _AggiungiPrenotazioneState createState() => _AggiungiPrenotazioneState();
}

class _AggiungiPrenotazioneState extends State<AggiungiPrenotazione> {
  addDataFamigli() {
    Future<DocumentReference> collectionReference =
        FirebaseFirestore.instance.collection('Prenotazione').add({
      'CognomePrenotazione': CognomePrenotazioneController.text,
      'DataDiInizio': formatter.format(DataInzio),
      'DataFine': formatter.format(Datafine),
      'NPersone': int.parse(NumeroOspitiController.text),
      'Prezzo': int.parse(PrezzoController.text),
      'Piano': Pianocontroller.text,
    });
  }

  @override
  static String CognomePrenotazione;
  var CognomePrenotazioneController = TextEditingController();
  var NumeroOspitiController = TextEditingController();
  var NumeroTelfonoController = TextEditingController();
  var PrezzoController = TextEditingController();
  var Pianocontroller = TextEditingController();

  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  DateTime DataInzio = DateTime.now();
  DateTime Datafine = DateTime.now();
  String CognomeNonValido = "Cognome non valido";
  String Parola = "";

  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: DraweNavigation(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Aggiungi Ospiti",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              input_text(TextInputType.text, " Cognome Prenotazione", false,
                  CognomePrenotazioneController),
              input_text(TextInputType.text, " Numero Ospiti", false,
                  NumeroOspitiController),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.teal,
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                  ),
                  onPressed: () {
                    Alert(context, "inserire data di inizio e fine soggiorno");
                  },
                  child: Text("inserire Data di inizio e fine soggiorno"),
                ),
              ),
              input_text(TextInputType.number, "Prezzo soggiorno", false,
                  PrezzoController),
              input_text(TextInputType.number, " Numero Di Telefono", false,
                  NumeroOspitiController),
              input_text(TextInputType.text, "Piano", false, Pianocontroller),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      if (CognomePrenotazioneController.text.length == 0) {
                        showAlertDialog(
                            context, Parola = "Cognome Prenotazione");
                        return;
                      }
                      if (NumeroTelfonoController.text.length == 0) {
                        showAlertDialog(context, Parola = "Telefono");
                        return;
                      }
                      if (NumeroOspitiController.text.length == 0) {
                        showAlertDialog(context, Parola = "Numero Ospiti");
                        return;
                      }
                      if (PrezzoController.text.length == 0) {
                        showAlertDialog(context, Parola = "Prezzo");
                        return;
                      }
                      if (Datafine == null) {
                        showAlertDialog(context, Parola = "Data Fine");
                        return;
                      }
                      if (DataInzio == null) {
                        showAlertDialog(context, Parola = "Data Inizio");
                        return;
                      }
                      if (Pianocontroller.text.length == 0) {
                        showAlertDialog(context, Parola = "Piano");
                        return;
                      }

                      {
                        addDataFamigli();

                        for (int i = 0;
                            i < int.parse(NumeroOspitiController.text);
                            i++) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AggiungiOspitiScreen(
                                  CognomePrenotazione:
                                      CognomePrenotazioneController.text)));
                        }
                      }
                      NumeroOspitiController.clear();
                      PrezzoController.clear();
                      NumeroTelfonoController.clear();
                      Pianocontroller.clear();
                      NumeroOspitiController.clear();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> Alert(BuildContext context, box) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(5),
          content: SizedBox(
            height: 300,
            width: 250,
            child: Scaffold(
              body: Column(
                children: [
                  SfDateRangePicker(
                    selectionMode: DateRangePickerSelectionMode.range,
                    onSelectionChanged: selectionChanged,
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Center(
              child: OutlinedButton(
                child: Text('Okay'),
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
    setState(() {
      DataInzio = args.value.startDate;
      Datafine = args.value.endDate;
    });
  }
}
