import 'package:flutter/material.dart';
import 'package:project/view/landingpage_view.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _onboardingPages = [
    // Page 1: Basic Description
    const _OnboardingPage(
      image: 'assets/images/welcome.jpg',
      title: 'Welcome to UniFootball',
      description:
          'Get the latest football updates, scores, and news at your fingertips.',
    ),
    // Page 2: Personalized Content
    const _OnboardingPage(
      image: 'assets/images/welcome.jpg',
      title: 'Personalized Content',
      description:
          'We offer personalized content based on your favorite teams and choices.',
    ),
    // Page 3: Get Started
    const _OnboardingPage(
      image: 'assets/images/welcome.jpg',
      title: 'Let\'s Get Started',
      description: 'Join now and experience football like never before.',
    ),
  ];

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _goToHome();
    }
  }

  void _skipPages() {
    _goToHome();
  }

  void _goToHome() {
    // Replace this with your navigation to the main app screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => const LandingPage()), // Dummy HomeScreen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 34, 33, 33), // Dark theme
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: _onboardingPages,
            ),
          ),
          // Bottom Navigation: Skip | Indicator | Next
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _skipPages,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ),
                Row(
                  children: List.generate(
                    _onboardingPages.length,
                    (index) => _buildDot(index),
                  ),
                ),
                TextButton(
                  onPressed: _nextPage,
                  child: Text(
                    _currentPage == 2 ? 'Get Started' : 'Next',
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? Colors.blue : Colors.white30,
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const _OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 250,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 32),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
