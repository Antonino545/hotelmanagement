import 'package:flutter/material.dart';
import 'package:hotelmanagement/screen/LoginScreen/welcome_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //debug false
      home: //Imposta come Home:Elenco Ospiti Attuali
          const welcome(),
      theme: ThemeData(
        // ignore: prefer__ructors

        appBarTheme: const AppBarTheme(
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
