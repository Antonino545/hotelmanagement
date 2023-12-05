import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hotelmanagement/components/AlertDialog.dart';
import 'package:hotelmanagement/screen/responsive/splitview.dart';

Future<void> loginEmail(
    {context,
    box,
    required TextEditingController email,
    required TextEditingController password}) async {
  if (email.text.isEmpty) {
    alert(context, "Devi inserire la tua mail");
    return;
  }
  if (password.text.isEmpty) {
    alert(context, "Devi inserire la tua password");
    return;
  }
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.text, password: password.text);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      alert(context, 'Email non collegata ad un account');
      return;
    } else if (e.code == 'wrong-password') {
      alert(
        context,
        'Password non corretta',
      );
      return;
    }
  }
  postlogin(context);
}
postlogin(context){
  FirebaseAuth.instance.userChanges().listen((user) {
    if (user == null) {
      if (kDebugMode) {
        print('User is currently signed out!');
      }
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const SplitView(),
      ));
      if (kDebugMode) {
        print('Login success');
      }
    }
  });
}
Future<UserCredential> signInWithGoogleIosAndroid() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
Future<UserCredential> signInWithGoogle() async {
  // Create a new provider
  GoogleAuthProvider googleProvider = GoogleAuthProvider();

  googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
  googleProvider.setCustomParameters({
    'login_hint': 'user@example.com'
  });

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithPopup(googleProvider);

  // Or use signInWithRedirect
  // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
}
Future<UserCredential> signInWithFacebookIosAndroid() async {
  if (kDebugMode) {
    print("Facebook");
  }
  // Trigger the sign-in flow
  final LoginResult loginResult = await FacebookAuth.instance.login();

  // Create a credential from the access token
  final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

  // Once signed in, return the UserCredential
  return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
}
Future<UserCredential> signInWithFacebook() async {
  // Create a new provider
  FacebookAuthProvider facebookProvider = FacebookAuthProvider();

  facebookProvider.addScope('email');
  facebookProvider.setCustomParameters({
    'display': 'popup',
  });

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithPopup(facebookProvider);

  // Or use signInWithRedirect
  // return await FirebaseAuth.instance.signInWithRedirect(facebookProvider);
}
singUp(
    {required TextEditingController password_1,
    required TextEditingController password_2,
    required TextEditingController email,
    context}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  if (password_1.text != password_2.text) {
    await alert(context, "Le password non coincidono");
  } else {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: email.text, password: password_1.text)
          .then((value) async {
        var user = FirebaseAuth.instance.currentUser;
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user?.uid)
            .set({'email': email.text, "bookingCode": 00000000});
      });
      if (kDebugMode) {
        print("Signed Up");
      }
      loginEmail(email: email, password: password_1);
    } catch (e) {
      /**  if (e.code == 'weak-password') {
        await alert(context, "Le password non rispetta i criteri di sicurezza");
      } else if (e.code == 'email-already-in-use') {
        await alert(context, "Questa mail é gia utilizzata");
      }*/
    }
  }
}


