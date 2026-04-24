import 'package:fitness_app/features/on_boarding/presentation/views/widgets/background.dart';
import 'package:fitness_app/features/on_boarding/presentation/views/widgets/bottom_panel.dart';
import 'package:fitness_app/features/on_boarding/presentation/views/widgets/onboarding_data.dart';
import 'package:fitness_app/features/on_boarding/presentation/views/widgets/page_view.dart';
import 'package:fitness_app/features/on_boarding/presentation/views/widgets/skip_botton.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/core/routes/app_route.dart';

// ─── Screen ───────────────────────────────────────────────────────────────────

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingData> _pages = const [
    OnboardingData(
      title: 'The Price Of Excellence\nIs Discipline',
      description:
          'Lorem Ipsum Dolor Sit Amet Consectetur. Eu Urna Ut Gravida Quis Id Pretium Purus. Mauris Massa',
      imagePath: 'assets/images/onboardingimage1.png',
    ),
    OnboardingData(
      title: 'Fitness Has Never Been\nSo Much Fun',
      description:
          'Lorem Ipsum Dolor Sit Amet Consectetur. Eu Urna Ut Gravida Quis Id Pretium Purus. Mauris Massa',
      imagePath: 'assets/images/onboardingimage2.png',
    ),
    OnboardingData(
      title: 'NO MORE EXCUSES\nDo It Now',
      description:
          'Lorem Ipsum Dolor Sit Amet Consectetur. Eu Urna Ut Gravida Quis Id Pretium Purus. Mauris Massa',
      imagePath: 'assets/images/onboardingimage3.png',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentIndex < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToLogin();
    }
  }

  void _onBack() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _navigateToLogin() {
    Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ── Background ──────────────────────────────────────────────────
          const OnboardingBackground(),

          // ── PageView ────────────────────────────────────────────────────
          OnboardingPageView(
            pages: _pages,
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentIndex = index),
          ),

          // ── Skip (top-right corner) ─────────────────────────────────────
          OnboardingSkipButton(
            currentIndex: _currentIndex,
            totalPages: _pages.length,
            onSkip: _navigateToLogin,
          ),

          // ── Bottom panel ────────────────────────────────────────────────
          OnboardingBottomPanel(
            pages: _pages,
            currentIndex: _currentIndex,
            onNext: _onNext,
            onBack: _onBack,
          ),
        ],
      ),
    );
  }
}
