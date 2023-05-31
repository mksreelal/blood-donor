import 'package:firebaseee/screenHome.dart';
import 'package:firebaseee/screenadd.dart';
import 'package:firebaseee/update.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ScreenHome(),
      routes: {
        'Screenadd': (context) => ScreenAdd(),
        'update': (context) => UpdateScreen()
      },
    );
  }
}
