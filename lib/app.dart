import 'package:flutter/material.dart';
import 'package:hotelmanagement/screen/LoginScreen/welcome_screen.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //debug false
      home: const welcome(), //Imposta come Home:Elenco Ospiti Attuali

      theme: ThemeData(
        // ignore: prefer_const_constructors
        appBarTheme: AppBarTheme(
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
