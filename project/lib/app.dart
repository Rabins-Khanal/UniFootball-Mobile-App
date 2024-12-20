import 'package:flutter/material.dart';
import 'package:project/core/app_theme/app_theme.dart';
import 'package:project/view/onboardingpage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Font and Theme',
      initialRoute: '/',
      theme: getApplicationTheme(),
      routes: {
        '/': (context) => const OnboardingScreen(),
      },
    );
  }
}
