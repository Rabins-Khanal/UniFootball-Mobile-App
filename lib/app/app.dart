import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_football_app/features/home/presentation/view_model/home_state.dart';
import 'package:uni_football_app/features/splash/presentation%20/view/splash_view.dart';
import 'package:uni_football_app/features/splash/presentation%20/view_model/splash_cubit.dart';

import '../core/theme/app_theme.dart';
import '../features/home/presentation/view_model/home_cubit.dart';
import '../features/news/presentation/view_model/news_bloc.dart';
import 'di/di.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>(), // Provide HomeCubit
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Unifootball App',
            theme: AppTheme.getApplicationTheme(isDarkMode: true),
            home: MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => getIt<NewsBloc>()),
                BlocProvider.value(value: getIt<SplashCubit>()),
              ],
              child: const SplashView(),
            ),
          );
        },
      ),
    );
  }
}
