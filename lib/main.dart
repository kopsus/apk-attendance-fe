import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/onboarding/views/onboarding_page.dart';

import 'features/onboarding/bloc/onboarding_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DistroApp());
}

class DistroApp extends StatelessWidget {
  const DistroApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Distro App',
      home: BlocProvider(
          create: (context) => OnboardingBloc()..add(CheckLogin()),
          child: const OnboardingPage()),
    );
  }
}
