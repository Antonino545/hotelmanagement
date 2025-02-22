// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBgKtoSOiOlNIg6Hax5dvNlDuUPbu93YuA',
    appId: '1:288333512846:web:b14c4dcc0fc875e63ac9df',
    messagingSenderId: '288333512846',
    projectId: 'hotel-management-9a530',
    authDomain: 'hotel-management-9a530.firebaseapp.com',
    databaseURL: 'https://hotel-management-9a530-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'hotel-management-9a530.appspot.com',
    measurementId: 'G-DNX1JC6ED8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB0rrVt5n_pDlsiyU3A0rrnPWkdvwQY8fM',
    appId: '1:288333512846:android:94c16b339a4b587a3ac9df',
    messagingSenderId: '288333512846',
    projectId: 'hotel-management-9a530',
    databaseURL: 'https://hotel-management-9a530-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'hotel-management-9a530.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDhff4EVnSp5ItZSFnLo303kftIHbjbDmE',
    appId: '1:288333512846:ios:faeeeeb0f01f3f6d3ac9df',
    messagingSenderId: '288333512846',
    projectId: 'hotel-management-9a530',
    databaseURL: 'https://hotel-management-9a530-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'hotel-management-9a530.appspot.com',
    androidClientId: '288333512846-k1qkicgnieras1a7u4udg770r8ndcgo3.apps.googleusercontent.com',
    iosClientId: '288333512846-9q2e54sok99ht3gviki4bmh7qfrlnngr.apps.googleusercontent.com',
    iosBundleId: 'com.antoninoincorvaia.hotelmanagement',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDhff4EVnSp5ItZSFnLo303kftIHbjbDmE',
    appId: '1:288333512846:ios:faeeeeb0f01f3f6d3ac9df',
    messagingSenderId: '288333512846',
    projectId: 'hotel-management-9a530',
    databaseURL: 'https://hotel-management-9a530-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'hotel-management-9a530.appspot.com',
    androidClientId: '288333512846-k1qkicgnieras1a7u4udg770r8ndcgo3.apps.googleusercontent.com',
    iosClientId: '288333512846-9q2e54sok99ht3gviki4bmh7qfrlnngr.apps.googleusercontent.com',
    iosBundleId: 'com.antoninoincorvaia.hotelmanagement',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBgKtoSOiOlNIg6Hax5dvNlDuUPbu93YuA',
    appId: '1:288333512846:web:0b840b685f4dded23ac9df',
    messagingSenderId: '288333512846',
    projectId: 'hotel-management-9a530',
    authDomain: 'hotel-management-9a530.firebaseapp.com',
    databaseURL: 'https://hotel-management-9a530-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'hotel-management-9a530.appspot.com',
    measurementId: 'G-JSSLEN4WRN',
  );
}
