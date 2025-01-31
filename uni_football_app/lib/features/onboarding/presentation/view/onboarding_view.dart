import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../auth/presentation/view/login_view.dart';
import '../view_model/onboarding_bloc.dart';
import '../view_model/onboarding_event.dart';
import '../view_model/onboarding_state.dart';

class OnboardingView extends StatelessWidget {
  OnboardingView({super.key});

  final PageController _pageController = PageController();
  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Welcome to Our App",
      "description": "Discover the best features and enhance your experience.",
      "image": "assets/images/onboarding1.png",
    },
    {
      "title": "Easy Booking",
      "description": "Book tickets easily and manage your trips hassle-free.",
      "image": "assets/images/onboarding2.png",
    },
    {
      "title": "Stay Updated",
      "description":
          "Get real-time updates and notifications about your bookings.",
      "image": "assets/images/onboarding3.png",
    },
  ];

  void _completeOnboarding(BuildContext context) async {
    await SharedPreferences.getInstance()
        .then((prefs) => prefs.setBool('hasSeenOnboarding', true));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => LoginView()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(),
      child: Scaffold(
        body: BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _onboardingData.length,
                    onPageChanged: (index) =>
                        context.read<OnboardingBloc>().add(NextPageEvent()),
                    itemBuilder: (_, index) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(_onboardingData[index]["image"]!,
                            height: 250),
                        const SizedBox(height: 20),
                        Text(_onboardingData[index]["title"]!,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(_onboardingData[index]["description"]!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _onboardingData.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 8,
                      width: state.currentPage == index ? 16 : 8,
                      decoration: BoxDecoration(
                        color: state.currentPage == index
                            ? Colors.blue
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (state.currentPage == _onboardingData.length - 1) {
                        _completeOnboarding(context);
                      } else {
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Text(state.currentPage == _onboardingData.length - 1
                        ? "Get Started"
                        : "Next"),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
