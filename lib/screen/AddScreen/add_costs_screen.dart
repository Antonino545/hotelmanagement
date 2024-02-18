// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/components/AlertDialog.dart';
import 'package:hotelmanagement/components/input.dart';

class AddCost extends StatefulWidget {
  const AddCost({super.key});

  @override
  AddCostState createState() => AddCostState();
}

class AddCostState extends State<AddCost> {
  addSpesa() {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      FirebaseFirestore.instance
          .collection('Date')
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
              defaultInputText(
                label: "Nome spesa",
                controller: nomeSpesaControlle,

              ),
              defaultInputText(
                label: "Descrizione",
                controller: descrizioneSpesaControlle,

              ),
              defaultInputNumber(
                label: "Costo spesa",
                controller: costoSpesaControlle,

              ),
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
