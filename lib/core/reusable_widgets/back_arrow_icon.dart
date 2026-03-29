import 'package:fitness_app/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class BackArrowIcon extends StatelessWidget {
  const BackArrowIcon({super.key});

  @override
  Widget build(BuildContext context) =>
      const Icon(Icons.arrow_circle_left_outlined, color: AppColors.primaryColor);
}
