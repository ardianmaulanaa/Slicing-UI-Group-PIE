import 'package:flutter/material.dart';
import 'personalization.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HydropoMe Personalization',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 23, 65, 25),
        ),
        useMaterial3: true,
      ),
      home: Step1Page(),
    );
  }
}
