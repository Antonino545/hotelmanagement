import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotelmanagement/components/AlertDialog.dart';
import 'package:hotelmanagement/components/input.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../responsive/pageScaffol.dart';
import 'aggiungi_ospiti_screen.dart';

class AggiungiPrenotazione extends StatefulWidget {
  const AggiungiPrenotazione({Key? key}) : super(key: key);

  @override
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
  DateTime dataInzio = DateTime.now();
  DateTime dataFine = DateTime.now();
  String cognomeNonValido = "Cognome non valido";
  String parola = "";

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("")),
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
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.teal,
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                  ),
                  onPressed: () {
                    alertDataRange(
                        context, "inserire data di inizio e fine soggiorno");
                  },
                  child: const Text("inserire Data di inizio e fine soggiorno"),
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
                    onPressed: () {
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
                        addDataFamigli();

                        for (int i = 0;
                            i < int.parse(numeroOspitiController.text);
                            i++) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AggiungiOspitiScreen(
                                  cognomeprenotazione:
                                      cognomePrenotazioneController.text)));
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
    setState(() {
      dataInzio = args.value.startDate;
      dataFine = args.value.endDate;
    });
  }

  addDataFamigli() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('Dati')
        .doc(user?.uid)
        .collection("prenotazioni")
        .doc(cognomePrenotazioneController.text)
        .set({
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
