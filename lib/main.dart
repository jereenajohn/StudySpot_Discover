import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:studyspot_discover/firebase_options.dart';

void main () async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(StudySpot_Discover());
}

class StudySpot_Discover extends StatelessWidget {
  const StudySpot_Discover({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}