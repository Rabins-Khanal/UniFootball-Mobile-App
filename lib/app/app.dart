import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/theme/app_theme.dart';
import '../features/news/presentation/view_model/news_bloc.dart'; // Import NewsBloc
import '../features/splash/presentation/view/splash_view.dart';
import '../features/splash/presentation/view_model/splash_cubit.dart';
import 'di/di.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unifootball App',
      theme: AppTheme.getApplicationTheme(isDarkMode: false),
      home: BlocProvider(
        create: (context) => getIt<NewsBloc>(), // Provide NewsBloc here
        child: BlocProvider.value(
          value: getIt<SplashCubit>(),
          child: SplashView(),
        ),
      ),
    );
  }
}