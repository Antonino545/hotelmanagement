import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      appBar: AppBar(
        title: Text(
          "Aggiungi Ospiti",
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: DraweNavigation(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: "Cognome Prenotazione",
                  hintText: "inserisci Cognome Prenotazione",
                ),
                controller: CognomePrenotazioneController,
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: "Numero Ospiti",
                  hintText: "inserisci Numero  Ospite",
                ),
                keyboardType: TextInputType.number,
                controller: NumeroOspitiController,
              ),
            ),
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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        _buildPopupDialog(context),
                  );
                },
                child: const Text("inserire Data di inizio e fine soggiorno"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: "Prezzo",
                  hintText: "inserisci Prezzo  Soggiorno",
                ),
                keyboardType: TextInputType.number,
                controller: PrezzoController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: "Numero Di Telefono",
                  hintText: "inserisci Numero di Telefono",
                ),
                keyboardType: TextInputType.number,
                controller: NumeroTelfonoController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: "Piano",
                  hintText: "inserisci il Piano",
                ),
                controller: Pianocontroller,
              ),
            ),
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  if (CognomePrenotazioneController.text.length == 0) {
                    showAlertDialog(context, Parola = "Cognome Prenotazione");
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
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, String parola1) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert;
    CupertinoAlertDialog alertios;
    // set up the AlertDialog
    if (Platform.isAndroid) {
      // Android-specific code
      alert = AlertDialog(
        title: Text("Inserisci " + parola1),
        actions: [
          okButton,
        ],
        elevation: 24.0,
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else {
      // iOS-specific code
      alertios = CupertinoAlertDialog(
        title: Text("Inserisci " + parola1),
        actions: [
          okButton,
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertios;
        },
      );
    }
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Inserire Data di inizio e fine soggiorno'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SfDateRangePicker(
              selectionMode: DateRangePickerSelectionMode.range,
              onSelectionChanged: selectionChanged,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      DataInzio = args.value.startDate;
      Datafine = args.value.endDate;
    });
  }
}
