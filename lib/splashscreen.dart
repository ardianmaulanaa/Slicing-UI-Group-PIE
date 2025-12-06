import 'package:flutter/material.dart';
import 'onboarding_1.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Onboarding1()),
        );
      },
      child: Scaffold(
        body: Center(
          child: Image.asset('assets/img/splashboarding/HydropoMe.png'),
        ),
      ),
    );
  }
}
