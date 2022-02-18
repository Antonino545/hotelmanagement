import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotelmanagement/screen/LoginScreen/welcome_screen.dart';
import 'package:hotelmanagement/screen/aggiungi_prenotazione_screen.dart';
import 'package:hotelmanagement/screen/elenco_ospiti_generale.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //debug false
      home: welcome (), //Imposta come Home:Elenco Ospiti Attuali
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,


        ),

        //imposto il tema
        brightness: Brightness.dark,
        primaryColor: Colors.teal,
        selectedRowColor: Colors.teal,
      ),
    );
  }
}
