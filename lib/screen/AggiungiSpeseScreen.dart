import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/drawer.dart';

import 'components/imput.dart';

class AggiungiSpeseScreen extends StatefulWidget {
  @override
  _AggiungiSpeseScreenState createState() => _AggiungiSpeseScreenState();
}

class _AggiungiSpeseScreenState extends State<AggiungiSpeseScreen> {
  addSpesa() {
    Future<DocumentReference> collectionReference =
        FirebaseFirestore.instance.collection('Spese').add({
      'CostoSpesa': int.parse(CostoSpesaControlle.text),
      'DescrizioneSpesa': DescrizioneSpesaControlle.text,
      'NomeSpesa': NomeSpesaControlle.text,
    });
  }

  var NomeSpesaControlle = TextEditingController();
  var DescrizioneSpesaControlle = TextEditingController();
  var CostoSpesaControlle = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      drawer: DraweNavigation(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Aggiungi Spese",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              imput_text("Nome spesa", false, NomeSpesaControlle),
              imput_text("Descrizione", false, DescrizioneSpesaControlle),
              imput_text("Costo spesa", false, CostoSpesaControlle),

              IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    if (NomeSpesaControlle.text.length !=
                        0) if (CostoSpesaControlle.text.length != 0) {
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
