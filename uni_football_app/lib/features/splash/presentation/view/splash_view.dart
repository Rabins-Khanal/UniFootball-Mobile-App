import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_football_app/app/constants/constant_theme.dart';

import '../view_model/splash_cubit.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Applying gradient background
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ThemeConstant.primaryColor,
              const Color.fromARGB(255, 19, 69, 115)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome !',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5),
                  ),
                  // Adding a smooth animation to the logo
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(seconds: 2),
                    child: SizedBox(
                      height: 400,
                      width: 400,
                      child: Image.asset('assets/images/splash.jpg'),
                    ),
                  ),
                  // Enhanced text style for the title
                  const SizedBox(height: 20),
                  const Text(
                    'UniFootball',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Adjusted size and color for version text

                  const SizedBox(height: 20),
                  // Adding animation to the progress indicator
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ],
              ),
            ),
            // Positioned footer text with a modern style
            Positioned(
              bottom: 20,
              left: MediaQuery.of(context).size.width / 4,
              child: const Text(
                'All ballers assemble',
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
