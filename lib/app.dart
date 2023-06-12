import 'package:flutter/material.dart';
import 'package:hotelmanagement/screen/LoginScreen/welcome_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //MaterialApp is the theme of the app
    return MaterialApp(
      title: 'Hotel Management',
      debugShowCheckedModeBanner: false,
      home: const Welcome(),
      theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
          ),
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
          /* colorScheme: const ColorScheme(
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
              surface: Colors.transparent),*/

          bottomAppBarTheme: const BottomAppBarTheme(color: Colors.black)
          // ignore: prefer_const_constructors
          ),
    );
  }
}
