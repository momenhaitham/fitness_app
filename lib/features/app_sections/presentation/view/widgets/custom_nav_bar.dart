import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/resources/app_colors.dart';
import 'package:fitness_app/core/reusable_widgets/transparent_container.dart';
import 'package:fitness_app/features/app_sections/domain/entities/custom_nav_item_model.dart';
import 'package:fitness_app/features/app_sections/presentation/view/widgets/custom_nav_bar_item.dart';
import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<CustomNavItemModel> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: TransparentContainer(
          height: 70,
          color: AppColors.blackColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: List.generate(items.length, (index) {
                final item = items[index];
                return Expanded(
                  child: CustomNavBarItem(
                    title: item.label.tr(),
                    icon: item.icon,
                    isSelected: currentIndex == index,
                    onTap: () => onTap(index),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
