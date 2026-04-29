import 'package:fitness_app/core/resources/assets_manager.dart';
import 'package:flutter/material.dart';

class OnboardingBackground extends StatelessWidget {
  const OnboardingBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetsImage.onBoardingBackGround,
      height: double.infinity,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}