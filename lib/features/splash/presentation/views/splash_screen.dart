// ignore_for_file: use_build_context_synchronously
import 'package:fitness_app/core/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(AssetsSvg.fitnessLaunchiconSvg, width: 200)
            .animate()
            .scale(
              delay: Duration(milliseconds: 700),
              duration: Duration(milliseconds: 300),
              
            ),
      ),
    );
  }
}
