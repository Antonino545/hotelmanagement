import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hotelmanagement/components/AlertDialog.dart';
import 'package:hotelmanagement/screen/AddScreen/add_costs_screen.dart';

import '../responsive/splitview.dart';

class Finance extends StatefulWidget {
  const Finance({super.key});
  @override
  State<Finance> createState() => _FinanceState();
}

class _FinanceState extends State<Finance> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hotel Management"),
        automaticallyImplyLeading: false,
      ),
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Date')
              .doc(user?.uid)
              .collection("Spese")
              .snapshots(),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot docSnap = snapshots.data!.docs[index];
                    return Slidable(
                      key: ObjectKey(docSnap.data()),
                      startActionPane: ActionPane(
                        // A motion is a widget used to control how the pane animates.
                        motion: const BehindMotion(),

                        // A pane can dismiss the Slidable.
                        dismissible: DismissiblePane(
                          onDismissed: () async {
                            await alertDelete(
                                context,
                                "Sei sicuro di cancellare questa Spesa",
                                user,
                                docSnap,
                                FirebaseFirestore.instance
                                    .collection('Date')
                                    .doc(user?.uid)
                                    .collection("Spese")
                                    .doc(docSnap.id)
                                    .delete());
                          },
                        ),

                        // All actions are defined in the children parameter.
                        children: [
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            onPressed: (direction) async {
                              await alertDelete(
                                  context,
                                  "Sei sicuro di cancellare questa Spesa",
                                  user,
                                  docSnap,
                                  FirebaseFirestore.instance
                                      .collection('Date')
                                      .doc(user?.uid)
                                      .collection("Spese")
                                      .doc(docSnap.id)
                                      .delete());
                            },
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                          ),
                          SlidableAction(
                              onPressed: (direction) async {
                                await alertDelete(
                                    context,
                                    "Sei sicuro di cancellare questa Spesa",
                                    user,
                                    docSnap,
                                    FirebaseFirestore.instance
                                        .collection('Date')
                                        .doc(user?.uid)
                                        .collection("Spese")
                                        .doc(docSnap.id)
                                        .delete());

                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SplitView()));
                              },
                              foregroundColor: Colors.white,
                              icon: Icons.edit),
                        ],
                      ),
                      child: Card(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            ListTile(
                              title:
                                  Text("Nome Spesa: ${docSnap["NomeSpesa"]}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Wrap(
                                children: [
                                  Text(
                                      "Descrizione: ${docSnap["DescrizioneSpesa"]}"),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Text("Costo Spesa: ${docSnap["CostoSpesa"]}"),
                                ],
                              ),
                            ),
                          ])),
                    );
                  });
            } else {
              return const Align(
                alignment: FractionalOffset.center,
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddCost()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
