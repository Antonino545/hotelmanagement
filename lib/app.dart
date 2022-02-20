import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotelmanagement/screen/ElencoScreen/elenco_ospiti_generale.dart';
import 'package:hotelmanagement/screen/LoginScreen/welcome_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //debug false
      home: welcome(), //Imposta come Home:Elenco Ospiti Attuali
      darkTheme: ThemeData.dark(),

      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
        ),
        buttonTheme: ButtonThemeData(),
        //imposto il tema
        primaryColor: Colors.teal,
        selectedRowColor: Colors.teal,
      ),
    );
  }
}
