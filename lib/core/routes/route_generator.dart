import 'package:fitness_app/core/routes/app_route.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/view/screens/forgetpassword_screen.dart';
import 'package:fitness_app/features/app_sections/presentation/view/pages/app_sections_page.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/view/screens/forgetpassword_screen.dart';
import 'package:fitness_app/features/auth/register/presentation/view/pages/register_page.dart';
import 'package:fitness_app/features/home/presentation/view/screen/home_page.dart';
import 'package:fitness_app/features/on_boarding/presentation/views/screen/on_boarding_screen.dart';

import 'package:fitness_app/features/splash/presentation/views/splash_screen.dart';
import 'package:fitness_app/features/workouts/presentation/view/pages/workouts_page.dart';
import 'package:flutter/material.dart';

import 'package:fitness_app/features/login/presentation/view/pages/login_page.dart';


class RouteGenerator {
  static Route<dynamic> getRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routes.register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());

      case Routes.workouts:
        return MaterialPageRoute(builder: (_) => const WorkoutsPage());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());

      case Routes.forgetPassword:
         return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
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
