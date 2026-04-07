import 'package:fitness_app/core/app_locale/app_locale.dart';
import 'package:fitness_app/core/resources/assets_manager.dart';
import 'package:fitness_app/features/app_sections/domain/entities/custom_nav_item_model.dart';
import 'package:fitness_app/features/app_sections/presentation/view_model/cubit/app_sections_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppSectionsCubit extends Cubit<AppSectionsStates> {
  AppSectionsCubit({@factoryParam PageController? pageController})
    : pageController = pageController ?? PageController(initialPage: 0),
      super(const AppSectionsStates(currentIndex: 0));
  final PageController pageController;

  final items = [
    CustomNavItemModel(
      label: AppLocale.explore,
      icon: AssetsSvg.homeIconSvg,
    ),
    CustomNavItemModel(label: "Chat", icon: AssetsSvg.chatIconSvg),
    CustomNavItemModel(
      label: AppLocale.workouts,
      icon: AssetsSvg.workoutIconSvg,
    ),
    CustomNavItemModel(
      label: AppLocale.profile,
      icon: AssetsSvg.profileIconSvg,
    ),
  ];
  void setCurrentIndex(int index) {
    emit(state.copyWith(currentIndex: index));
    if (pageController.hasClients) {
      pageController.jumpToPage(index);
    }
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
