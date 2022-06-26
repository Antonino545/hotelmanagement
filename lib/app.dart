import 'package:flutter/material.dart';
import 'package:hotelmanagement/screen/LoginScreen/welcome_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //debug false
      home: const Welcome(),
      theme: ThemeData(
          // ignore: prefer__ructors
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
          ),
          bottomAppBarColor: Colors.black,
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(textStyle: const TextStyle())),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(500, 50),
              textStyle: const TextStyle(
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
          colorScheme: ColorScheme(
              brightness: Brightness.dark,
              background: Colors.black,
              error: Colors.red,
              onBackground: Colors.teal,
              onError: Colors.red,
              onPrimary: Colors.white,
              onSecondary: Colors.white,
              onSurface: Colors.white,
              primary: Colors.teal,
              secondary: Colors.teal,
              surface: Colors.transparent)
          // ignore: prefer_const_constructors
          ),
    );
  }
}
