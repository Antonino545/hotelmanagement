// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/components/AlertDialog.dart';
import 'package:hotelmanagement/components/input.dart';

class AggiungiSpeseScreen extends StatefulWidget {
  const AggiungiSpeseScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AggiungiSpeseScreenState createState() => _AggiungiSpeseScreenState();
}

class _AggiungiSpeseScreenState extends State<AggiungiSpeseScreen> {
  addSpesa() {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      FirebaseFirestore.instance
          .collection('Dati')
          .doc(user?.uid)
          .collection("Spese")
          .add({
        'CostoSpesa': int.parse(costoSpesaControlle.text),
        'DescrizioneSpesa': descrizioneSpesaControlle.text,
        'NomeSpesa': nomeSpesaControlle.text,
      });
    } catch (e) {
      alert(context, e.toString());
    }
  }

  var nomeSpesaControlle = TextEditingController();
  var descrizioneSpesaControlle = TextEditingController();
  var costoSpesaControlle = TextEditingController();
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
              const Text(
                "Aggiungi Spese",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              inputText(
                  TextInputType.text, "Nome spesa", false, nomeSpesaControlle),
              inputText(TextInputType.text, "Descrizione", false,
                  descrizioneSpesaControlle),
              inputInt(TextInputType.number, "Costo spesa", false,
                  costoSpesaControlle),
              IconButton(
                  icon: const Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    if (nomeSpesaControlle.text.isNotEmpty &&
                        costoSpesaControlle.text.isNotEmpty) {
                      addSpesa();
                    }
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
