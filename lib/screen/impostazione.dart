import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'loginScreen/welcome_screen.dart';

class Impostazioni extends StatefulWidget {
  const Impostazioni({super.key});

  @override
  State<Impostazioni> createState() => _ImpostazioniState();
}

class _ImpostazioniState extends State<Impostazioni> {
  bool darktheme = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Impostazioni"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      "Logout",
                      style: TextStyle(fontSize: 20),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    IconButton(
                        onPressed: () async {
                          var context = this.context;
                          await FirebaseAuth.instance.signOut();
                          if (!context.mounted) return;
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Welcome()));
                        },
                        icon: const Icon(Icons.logout))
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
