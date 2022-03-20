import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(); //inizializzare firebase
  await FirebasePerformance.instance;
  await FirebaseAppCheck.instance.activate();
  runApp(const App());
}
