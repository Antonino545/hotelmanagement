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
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  textStyle: const TextStyle(
            color: Colors.teal,
          ))),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(500, 50),
              textStyle: const TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 30.0,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          cardTheme: CardTheme(
            elevation: 4,
            margin: const EdgeInsets.all(8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          iconTheme: const IconThemeData(color: Colors.teal),
          // ignore: prefer_const_constructors
          colorScheme: ColorScheme(
              brightness: Brightness.dark,
              primary: Colors.teal,
              onPrimary: Colors.white,
              secondary: Colors.teal,
              onSecondary: Colors.white,
              error: Colors.teal,
              onError: Colors.teal,
              background: Colors.transparent,
              onBackground: Colors.transparent,
              surface: Colors.teal,
              onSurface: Colors.teal)),
    );
  }
}
