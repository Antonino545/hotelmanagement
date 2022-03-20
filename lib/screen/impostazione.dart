import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'LoginScreen/welcome_screen.dart';

class Impostazioni extends StatefulWidget {
  const Impostazioni({Key? key}) : super(key: key);

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
          title: Text("Impostazioni"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Padding(
                // Texfield Maggiorenne
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      "Tema scuro",
                      style: TextStyle(fontSize: 20),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    Switch.adaptive(
                      value: darktheme,
                      onChanged: (value) {
                        setState(() {
                          darktheme = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
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
                        onPressed: () async => {
                              await FirebaseAuth.instance.signOut(),
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const welcome()))
                            },
                        icon: Icon(Icons.logout))
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
