// GENERATED CODE - DO NOT MODIFY BY HAND
// Generated at: 2026-03-29 07:26:29.112315

import 'package:fitness_app/core/routes/app_route.dart';
import 'package:fitness_app/features/app_sections/presentation/view/pages/app_sections_page.dart';
import 'package:fitness_app/features/on_boarding/presentation/views/on_boarding_screen.dart';
import 'package:fitness_app/features/splash/presentation/views/splash_screen.dart';
import 'package:flutter/material.dart';

// TODO: Uncomment imports when screens are ready:
// import 'package:fitness_app/feature/splash/presentation/views/splash_screen.dart';
// import 'package:fitness_app/feature/login/presentation/views/login_screen.dart';
// import 'package:fitness_app/feature/home/presentation/views/home_screen.dart';
// import 'package:fitness_app/feature/onboarding/presentation/views/onboarding_screen.dart';
// import 'package:fitness_app/feature/forget_password/presentation/views/forget_password_screen.dart';

class RouteGenerator {
  static Route<dynamic> getRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
        
      case Routes.login:
        // TODO: Uncomment when LoginScreen is ready
        // return MaterialPageRoute(builder: (_) => const LoginScreen());
        return unDefinedRoute();
      case Routes.home:
        // TODO: Uncomment when HomeScreen is ready
        // return MaterialPageRoute(builder: (_) => const HomeScreen());
        return unDefinedRoute();
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
        
      case Routes.forgetPassword:
        // TODO: Uncomment when ForgetPasswordScreen is ready
        // return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
        return unDefinedRoute();
      case Routes.appSections:
      return MaterialPageRoute(builder: (_) => AppSectionsPage());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('No Route Found')),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }
}
