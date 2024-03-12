import 'package:flutter/material.dart';
import 'package:myapp/features/onboarding/views/onboarding_page.dart';

void main() {
  runApp(const DistroApp());
}

class DistroApp extends StatelessWidget {
  const DistroApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Distro App',
      home: const OnboardingPage(),
    );
  }
}
