
import 'package:fitness_app/core/resources/assets_manager.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              AssetsImage.onBoardingBackGround,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ],
        )
      ),
    );
  }

}