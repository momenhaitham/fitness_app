import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/features/home/presentation/view/widgets/category_section_widget.dart';
import 'package:fitness_app/features/home/presentation/view/widgets/food_section_widget.dart';
import 'package:fitness_app/features/home/presentation/view/widgets/home_header_widget.dart';
import 'package:fitness_app/features/home/presentation/view/widgets/recommendation_section_widget.dart';
import 'package:fitness_app/features/home/presentation/view/widgets/workout_section_widget.dart';
import 'package:fitness_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:fitness_app/features/home/presentation/view/widgets/popular_training_widget.dart';
import 'package:fitness_app/features/home/presentation/view_model/home_event.dart';
import 'package:fitness_app/features/home/presentation/view_model/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/config/di/di.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocProvider مرة واحدة بره كل حاجة
    return BlocProvider(
      create: (_) => getIt<HomeCubit>()..doAction(GetAllDataEvent()),
      child: SafeArea(
        child: BlocBuilder<HomeCubit, HomeStates>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ===== HEADER =====
                    const HomeHeaderWidget(),
                    const SizedBox(height: 16),

                    // ===== CATEGORY (filter chips) =====
                    // CategorySectionWidget(),
                    _buildSection(
                      state: state.workOutState,
                      loadedBuilder: (data) => CategorySectionWidget(
                        musclesGroup: data.musclesGroup,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ===== RECOMMENDATION TO DAY =====
                    _buildSection(
                      state: state.recommendationState,
                      loadedBuilder: (data) => RecommendationSectionWidget(
                        muscles: data.muscles,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ===== UPCOMING WORKOUTS (chips + cards) =====
                    _buildSection(
                      state: state.workOutState,
                      loadedBuilder: (data) => WorkoutSectionWidget(
                        musclesGroup: data.musclesGroup,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ===== FOOD / RECOMMENDATION FOR YOU =====
                    _buildSection(
                      state: state.foodState,
                      loadedBuilder: (data) => FoodSectionWidget(
                        categories: data.categories,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ===== POPULAR TRAINING (static) =====
                    const PopularTrainingSectionWidget(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSection<T>({
    required BaseState<T> state,
    required Widget Function(T data) loadedBuilder,
  }) {
    if (state.isLoading == true) {
      return const SizedBox(
        height: 90,
        child: Center(
          child: CircularProgressIndicator(color: Colors.orange),
        ),
      );
    }
    if (state.error != null) {
      return Center(
        child: Text(
          state.error.toString(),
          style: const TextStyle(color: Colors.red),
        ),
      );
    }
    if (state.data != null) {
      return loadedBuilder(state.data as T);
    }
    return const SizedBox.shrink();
  }
}




















// import 'package:fitness_app/config/base_state/base_state.dart';
// import 'package:fitness_app/core/resources/assets_manager.dart';
// import 'package:fitness_app/features/home/presentation/view/widgets/category_section_widget.dart';
// import 'package:fitness_app/features/home/presentation/view/widgets/food_section_widget.dart';
// import 'package:fitness_app/features/home/presentation/view/widgets/home_header_widget.dart';
// import 'package:fitness_app/features/home/presentation/view/widgets/recommendation_section_widget.dart';
// import 'package:fitness_app/features/home/presentation/view/widgets/workout_section_widget.dart';
// import 'package:fitness_app/features/home/presentation/view_model/home_cubit.dart';
// import 'package:fitness_app/features/home/presentation/view_model/home_event.dart';
// import 'package:fitness_app/features/home/presentation/view_model/home_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fitness_app/config/di/di.dart';

// class HomeBody extends StatelessWidget {
//   const HomeBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children:[
//     //   Image.asset(
//     //         AssetsImage.BackGroundHome,
//     //         height: double.infinity,
//     //         width: double.infinity,
//     //         fit: BoxFit.cover,
//     //       ),
//        SafeArea(
//         child: BlocProvider(
//           create: (_) => getIt<HomeCubit>()..doAction(GetAllDataEvent()),
        
//           child: SafeArea(
//             child: BlocBuilder<HomeCubit, HomeStates>(
//               builder: (context, state) {
//                 return SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const HomeHeaderWidget(),
//                         const SizedBox(height: 16),
        
//                         // ===== CATEGORY =====
//                         CategorySectionWidget(),
//                         const SizedBox(height: 24),
        
//                         // ===== RECOMMENDATION =====
//                         _buildSection(
//                           state: state.recommendationState,
//                           loadedBuilder: (data) =>
//                               RecommendationSectionWidget(muscles: data.muscles),
//                         ),
//                         const SizedBox(height: 24),
        
//                         // ===== WorkOut =====
//                         _buildSection(
//                           state: state.workOutState,
//                           loadedBuilder: (data) =>
//                               WorkoutSectionWidget(musclesGroup: data.musclesGroup),
//                         ),
        
//                         const SizedBox(height: 24),
        
//                         // ===== FOOD =====
//                         _buildSection(
//                           state: state.foodState,
//                           loadedBuilder: (data) =>
//                               FoodSectionWidget(categories: data.categories),
//                         ),
//                         const SizedBox(height: 24),
        
//                         // ===== RECOMMENDATION =====
//                         _buildSection(
//                           state: state.recommendationState,
//                           loadedBuilder: (data) =>
//                               RecommendationSectionWidget(muscles: data.muscles),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ),]
//     );
//   }

//   Widget _buildSection<T>({
//     required BaseState<T> state,
//     required Widget Function(T data) loadedBuilder,
//   }) {
//     if (state.isLoading == true) {
//       return const Center(
//         child: CircularProgressIndicator(color: Colors.orange),
//       );
//     }
//     if (state.error != null) {
//       return Center(
//         child: Text(
//           state.error.toString(),
//           style: const TextStyle(color: Colors.red),
//         ),
//       );
//     }
//     if (state.data != null) {
//       return loadedBuilder(state.data as T);
//     }
//     return const SizedBox.shrink();
//   }
// }
