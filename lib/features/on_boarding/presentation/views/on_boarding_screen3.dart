import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/app_locale/app_locale.dart';
import 'package:fitness_app/core/resources/app_colors.dart';
import 'package:fitness_app/core/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/core/routes/app_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingScreen3 extends StatefulWidget {
  const OnBoardingScreen3({super.key});

  @override
  State<OnBoardingScreen3> createState() => _OnBoardingScreen3State();
}

class _OnBoardingScreen3State extends State<OnBoardingScreen3> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;

    final List<_OnboardingData> pages = const [
      _OnboardingData(
        title: 'The Price Of Excellence\nIs Discipline',
        description:
            'Lorem Ipsum Dolor Sit Amet Consectetur. Eu Urna Ut Gravida Quis Id Pretium Purus. Mauris Massa',
        imagePath: 'assets/images/onboarding_1.png',
      ),
      _OnboardingData(
        title: 'Fitness Has Never Been\nSo Much Fun',
        description:
            'Lorem Ipsum Dolor Sit Amet Consectetur. Eu Urna Ut Gravida Quis Id Pretium Purus. Mauris Massa',
        imagePath: 'assets/images/onboarding_2.png',
      ),
      _OnboardingData(
        title: 'NO MORE EXCUSES\nDo It Now',
        description:
            'Lorem Ipsum Dolor Sit Amet Consectetur. Eu Urna Ut Gravida Quis Id Pretium Purus. Mauris Massa',
        imagePath: 'assets/images/onboarding_3.png',
      ),
    ];
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
            Column(
              children: [
                const SizedBox(height: 90),

                Image.asset("assets/images/onboardingimage3.png"),
                const SizedBox(height: 0),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.45),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.08),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'the price of excellence \n           is discipline',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 20.sp,
                              letterSpacing: 0.5,
                            ),
                      ),

                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          pages[currentIndex].description,
                          key: ValueKey('d$currentIndex'),
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 13,
                            height: 1.6,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 75,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: IconButton(
                              icon: Text(
                                "Back",
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineMedium,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.onboarding2,
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 205),
                          Container(
                            height: 50,
                            width: 75,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: IconButton(
                              icon: Text(
                                "Next",
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineMedium,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.home);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
// ─── Data model ───────────────────────────────────────────────────────────────

class _OnboardingData {
  final String title;
  final String description;
  final String imagePath;

  const _OnboardingData({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}
