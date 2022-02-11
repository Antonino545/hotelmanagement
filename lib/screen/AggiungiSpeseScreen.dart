import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/drawer.dart';

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
          title: Text(
        "Aggiungi Spese",
        style: TextStyle(color: Colors.white),
      )),
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
                  labelText: "Spese",
                  hintText: "inserisci Nome della Spesa",
                ),
                controller: NomeSpesaControlle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: "Descrizione",
                  hintText: "inserisci Descrizione della Spesa",
                ),
                controller: DescrizioneSpesaControlle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  labelText: "Costo",
                  hintText: "inserisci Costo della Spesa",
                ),
                controller: CostoSpesaControlle,
              ),
            ),
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
    );
  }
}
