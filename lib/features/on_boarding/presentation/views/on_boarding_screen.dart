import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/app_locale/app_locale.dart';
import 'package:fitness_app/core/resources/assets_manager.dart';
import 'package:fitness_app/core/routes/app_route.dart';
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
            Text(
              AppLocale.already_have_account.tr(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Image.asset(
              AssetsImage.onBoardingBackGround,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: IconButton(
                icon: Text(
                  "kemo",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.login);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
