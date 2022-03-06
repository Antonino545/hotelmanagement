import 'package:flutter/material.dart';
import 'package:hotelmanagement/drawer.dart';
import 'package:hotelmanagement/screen/responsive/splitview.dart';

class Impostazioni extends StatefulWidget {
  Impostazioni({Key? key}) : super(key: key);

  @override
  State<Impostazioni> createState() => _ImpostazioniState();
}

class _ImpostazioniState extends State<Impostazioni> {
  bool darktheme = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Impostazioni",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
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
                  Expanded(
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
          ],
        ),
      )),
    );
  }
}
