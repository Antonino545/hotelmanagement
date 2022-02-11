import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/app.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    print("web");
    var firebaseApp = await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCUkeUdVYnMWZ5OtBMgzYmP00TzXdrY1lw",
            authDomain: "familyovertheworldsocial.firebaseapp.com",
            projectId: "familyovertheworldsocial",
            storageBucket: "familyovertheworldsocial.appspot.com",
            messagingSenderId: "1060756069449",
            appId: "1:1060756069449:web:3737e6d9ec07528284f398"));
  }
  await Firebase.initializeApp(); //inizializzare firebase
  runApp(App());
}
