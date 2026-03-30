// ignore_for_file: use_build_context_synchronously
import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/resources/assets_manager.dart';
import 'package:fitness_app/core/routes/app_route.dart';
import 'package:fitness_app/core/utils/helper_function.dart';
import 'package:fitness_app/features/splash/presentation/view_model/splash_event.dart';
import 'package:fitness_app/features/splash/presentation/view_model/splash_intent.dart';
import 'package:fitness_app/features/splash/presentation/view_model/splash_state.dart';
import 'package:fitness_app/features/splash/presentation/view_model/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// tutorial for testing features and ui :)
// the application starts here, if you want to test a feature you are working on or testing the ui of a screen
// you don't have to go throw the entire flow of the application to get to the point you want to test 
// instead you can directly navigate to the screen you want to test or work on by just changing the route you want to navigate to
// in the 3 diffrent casees blow to the screen you want to test and after finishing your work 
// you can revert them back to the original values to make the application work as it should again
// AND PLEASE DONT FORGET TO REVERT THEM BACK TO THE ORIGINAL VALUES
// have a great day :)

class _SplashScreenState extends State<SplashScreen> {
  final SplashViewModel splashViewModel = getIt<SplashViewModel>();

  @override
  void initState() {
    super.initState();
    splashViewModel.doIntent(NavigateAction());
    splashViewModel.cubitStream.listen((event) {
      switch (event) {
        case NavigateToLoginEvent():
          if (mounted) {
            Navigator.pushReplacementNamed(context, Routes.login);
          }
          break;
        case NavigateToMainFlowEvent():
          if (mounted) {
            Navigator.pushReplacementNamed(context, Routes.home);
          }
        case NavigateToOnboardingEvent():
          if (mounted) {
            Navigator.pushReplacementNamed(context, Routes.onboarding);
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashViewModel, SplashState>(
      bloc: splashViewModel,
      listener: (context, state) {
        if (state.splashState.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(getException(state.splashState.error)),
            ),
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Image.asset(AssetsImage.fitnessSplash, height: 200, width: 200)
              .animate()
              .scale(
                delay: Duration(milliseconds: 1400),
                duration: Duration(milliseconds: 500),
              ),
        ),
      ),
    );
  }
}
