
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yoursbuilder/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB-I0TQye23eKYCKr8_I3UbL-hxl6dmO0s",
      authDomain: "yoursbuilder-61876.firebaseapp.com",
      projectId: "yoursbuilder-61876",
      storageBucket: "yoursbuilder-61876.appspot.com",
      messagingSenderId: "82183358312",
      appId: "1:82183358312:web:65be6ad54c3f67bf9c78dd",
      measurementId: "G-HCL1BRXB0X",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customer Feedback',
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MouseRegion(
          onHover: (_) {}, // absorb hover without triggering errors
          child: child!,
        );
      },
      home: CustomerForm(), // or your main widget
    );
  }
}


