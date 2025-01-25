import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UniFootball',
      theme: AppTheme.getApplicationTheme(isDarkMode: false),
      // home: BlocProvider.value(
      //   value: getIt<SplashCubit>(),
      //   child: SplashView(),
      //),
    );
  
  }
}
