// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/drawer.dart';
import 'package:hotelmanagement/screen/components/input.dart';

class AggiungiSpeseScreen extends StatefulWidget {
  const AggiungiSpeseScreen({Key key}) : super(key: key);

  @override
  _AggiungiSpeseScreenState createState() => _AggiungiSpeseScreenState();
}

class _AggiungiSpeseScreenState extends State<AggiungiSpeseScreen> {
  addSpesa() {
    FirebaseFirestore.instance.collection('Spese').add({
      'CostoSpesa': int.parse(costoSpesaControlle.text),
      'DescrizioneSpesa': descrizioneSpesaControlle.text,
      'NomeSpesa': nomeSpesaControlle.text,
    });
  }

  var nomeSpesaControlle = TextEditingController();
  var descrizioneSpesaControlle = TextEditingController();
  var costoSpesaControlle = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const DraweNavigation(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Aggiungi Spese",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              inputText(
                  TextInputType.text, "Nome spesa", false, nomeSpesaControlle),
              inputText(TextInputType.text, "Descrizione", false,
                  descrizioneSpesaControlle),
              inputText(TextInputType.number, "Costo spesa", false,
                  costoSpesaControlle),
              IconButton(
                  icon: const Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    if (nomeSpesaControlle.text.isNotEmpty &&
                        costoSpesaControlle.text.isNotEmpty) {
                      addSpesa();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
