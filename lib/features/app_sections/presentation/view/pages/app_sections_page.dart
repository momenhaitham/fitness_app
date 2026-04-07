import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/features/app_sections/presentation/view/widgets/custom_nav_bar.dart';
import 'package:fitness_app/features/app_sections/presentation/view_model/cubit/app_sections_cubit.dart';
import 'package:fitness_app/features/app_sections/presentation/view_model/cubit/app_sections_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppSectionsPage extends StatelessWidget {
  const AppSectionsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AppSectionsCubit>(),
      child: Scaffold(
        body: BlocBuilder<AppSectionsCubit, AppSectionsStates>(
          builder: (context, state) {
            final cubit = context.read<AppSectionsCubit>();
            return PageView(
              controller: cubit.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                //TODO: add the pages of the app sections
              ],
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<AppSectionsCubit, AppSectionsStates>(
          builder: (context, state) {
            final cubit = context.read<AppSectionsCubit>();
            return CustomNavBar(
              items: cubit.items,
              currentIndex: state.currentIndex,
              onTap: cubit.setCurrentIndex,
            );
          },
        ),
      ),
    );
  }
}
