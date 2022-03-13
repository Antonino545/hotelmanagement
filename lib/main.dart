import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';
import 'package:hotelmanagement/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(); //inizializzare firebase
  /*await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: '6LenyBseAAAAAEmaR4u8yNchkWuKi51pi3j_7Imz',
  );*/
  runApp(const App());
}
