import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/resources/app_colors.dart';
import 'package:fitness_app/core/routes/app_route.dart';
import 'package:fitness_app/features/popular_training/domain/entities/exercise_entity.dart';
import 'package:fitness_app/features/popular_training/presentation/view_model/popular_training_cubit.dart';
import 'package:fitness_app/features/popular_training/presentation/view_model/popular_training_event.dart';
import 'package:fitness_app/features/popular_training/presentation/view_model/popular_training_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTrainingSectionWidget extends StatelessWidget {
  const PopularTrainingSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PopularTrainingCubit>()
        ..doAction(GetAllPopularTrainingDataEvent()),
      child: const _PopularTrainingBody(),
    );
  }
}

// ─── Body ────────────────────────────────────────────────────────────────────

class _PopularTrainingBody extends StatefulWidget {
  const _PopularTrainingBody();

  @override
  State<_PopularTrainingBody> createState() => _PopularTrainingBodyState();
}

class _PopularTrainingBodyState extends State<_PopularTrainingBody> {
  String? _selectedLevelId;
  String? _selectedMuscleId;

  // بعد ما الـ levels والـ muscles يوصلوا نجيب الـ exercises تلقائياً
  void _fetchExercisesIfReady(PopularTrainingStates state) {
    final muscleId = state.musclesState.data?.firstOrNull?.id;
    final levelId = state.levelsState.data?.firstOrNull?.id;

    if (muscleId == null || levelId == null) return;

    // أول مرة بس
    if (_selectedMuscleId == null && _selectedLevelId == null) {
      _selectedMuscleId = muscleId;
      _selectedLevelId = levelId;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        context.read<PopularTrainingCubit>().doAction(
              GetExercisesEvent(
                primeMoverMuscleId: muscleId,
                difficultyLevelId: levelId,
              ),
            );
      });
    }
  }

  void _onLevelSelected(String levelId, PopularTrainingStates state) {
    if (_selectedLevelId == levelId) return;
    setState(() => _selectedLevelId = levelId);

    final muscleId =
        _selectedMuscleId ?? state.musclesState.data?.firstOrNull?.id;
    if (muscleId == null) return;

    context.read<PopularTrainingCubit>().doAction(
          GetExercisesEvent(
            primeMoverMuscleId: muscleId,
            difficultyLevelId: levelId,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularTrainingCubit, PopularTrainingStates>(
      builder: (context, state) {
        _fetchExercisesIfReady(state);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Popular Training',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, Routes.workouts),
                  child: Text(
                    'See All',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primaryColor,
                      decorationThickness: 2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // ── Level Chips ──────────────────────────────────────────────────
            _buildLevelsChips(state),
            const SizedBox(height: 12),

            // ── Exercise Cards ───────────────────────────────────────────────
            _buildExerciseCards(state),
          ],
        );
      },
    );
  }

  // ─── Levels Chips ──────────────────────────────────────────────────────────

  Widget _buildLevelsChips(PopularTrainingStates state) {
    final levelsState = state.levelsState;

    if (levelsState.isLoading == true) {
      return _LevelsShimmer();
    }

    if (levelsState.data == null || levelsState.data!.isEmpty) {
      return const SizedBox.shrink();
    }

    final levels = levelsState.data!;
    final selectedId = _selectedLevelId ?? levels.firstOrNull?.id;

    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: levels.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final level = levels[index];
          final isSelected = level.id == selectedId;

          return GestureDetector(
            onTap: () => _onLevelSelected(level.id, state),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryColor
                    : Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryColor
                      : Colors.white.withValues(alpha: 0.15),
                  width: 1,
                ),
              ),
              child: Text(
                level.name,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white70,
                  fontSize: 13,
                  fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ─── Exercise Cards ────────────────────────────────────────────────────────

  Widget _buildExerciseCards(PopularTrainingStates state) {
    final exercisesState = state.exercisesState;

    if (exercisesState.isLoading == true) {
      return _ExercisesShimmer();
    }

    if (exercisesState.error != null) {
      return Center(
        child: Text(
          exercisesState.error.toString(),
          style: const TextStyle(color: Colors.red, fontSize: 12),
        ),
      );
    }

    if (exercisesState.data == null || exercisesState.data!.isEmpty) {
      return const SizedBox(
        height: 190,
        child: Center(
          child: Text(
            'No exercises found',
            style: TextStyle(color: Colors.white54),
          ),
        ),
      );
    }

    final exercises = exercisesState.data!;

    return SizedBox(
      height: 190,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: exercises.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) =>
            _ExerciseCard(exercise: exercises[index]),
      ),
    );
  }
}

// ─── Exercise Card ────────────────────────────────────────────────────────────

class _ExerciseCard extends StatelessWidget {
  final ExerciseEntity exercise;

  const _ExerciseCard({required this.exercise});

  Color get _levelColor {
    switch (exercise.difficultyLevel.toLowerCase()) {
      case 'beginner':
        return const Color(0xFFFF8C00);
      case 'intermediate':
        return const Color(0xFF4CAF50);
      case 'advanced':
        return const Color(0xFFF44336);
      default:
        return const Color(0xFFFF8C00);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Stack(
        children: [
          // ── Background ───────────────────────────────────────────────────
          Container(
            width: 170,
            height: 190,
            color: const Color(0xFF1E1E1E),
            child: const Icon(
              Icons.fitness_center,
              color: Colors.orange,
              size: 40,
            ),
          ),

          // ── Dark Gradient Overlay ────────────────────────────────────────
          Container(
            width: 170,
            height: 190,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.1),
                  Colors.black.withValues(alpha: 0.80),
                ],
              ),
            ),
          ),

          // ── Content ──────────────────────────────────────────────────────
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.exercise,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      exercise.primaryEquipment,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: _levelColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _levelColor.withValues(alpha: 0.6),
                          width: 0.8,
                        ),
                      ),
                      child: Text(
                        exercise.difficultyLevel,
                        style: TextStyle(
                          color: _levelColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Shimmers ─────────────────────────────────────────────────────────────────

class _LevelsShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, __) => Container(
          width: 70,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

class _ExercisesShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (_, __) => Container(
          width: 170,
          height: 190,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}















// import 'package:fitness_app/config/base_state/base_state.dart';
// import 'package:fitness_app/config/di/di.dart';
// import 'package:fitness_app/core/resources/app_colors.dart';
// import 'package:fitness_app/core/routes/app_route.dart';
// import 'package:fitness_app/features/popular_training/domain/entities/exercise_entity.dart';
// import 'package:fitness_app/features/popular_training/domain/entities/level_entity.dart';
// import 'package:fitness_app/features/popular_training/presentation/view_model/popular_training_cubit.dart';
// import 'package:fitness_app/features/popular_training/presentation/view_model/popular_training_event.dart';
// import 'package:fitness_app/features/popular_training/presentation/view_model/popular_training_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class PopularTrainingSectionWidget extends StatelessWidget {
//   const PopularTrainingSectionWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => getIt<PopularTrainingCubit>()
//         ..doAction(GetAllPopularTrainingDataEvent()),
//       child: const _PopularTrainingBody(),
//     );
//   }
// }

// // ─── Body ────────────────────────────────────────────────────────────────────

// class _PopularTrainingBody extends StatefulWidget {
//   const _PopularTrainingBody();

//   @override
//   State<_PopularTrainingBody> createState() => _PopularTrainingBodyState();
// }

// class _PopularTrainingBodyState extends State<_PopularTrainingBody> {
//   String? _selectedLevelId;
//   String? _selectedMuscleId;

//   // بعد ما الـ levels والـ muscles يوصلوا نجيب الـ exercises تلقائياً
//   void _fetchExercisesIfReady(PopularTrainingStates state) {
//     final muscleId = state.musclesState.data?.firstOrNull?.id;
//     final levelId = state.levelsState.data?.firstOrNull?.id;

//     if (muscleId == null || levelId == null) return;

//     // أول مرة بس
//     if (_selectedMuscleId == null && _selectedLevelId == null) {
//       _selectedMuscleId = muscleId;
//       _selectedLevelId = levelId;
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (!mounted) return;
//         context.read<PopularTrainingCubit>().doAction(
//               GetExercisesEvent(
//                 primeMoverMuscleId: muscleId,
//                 difficultyLevelId: levelId,
//               ),
//             );
//       });
//     }
//   }

//   void _onLevelSelected(String levelId, PopularTrainingStates state) {
//     if (_selectedLevelId == levelId) return;
//     setState(() => _selectedLevelId = levelId);

//     final muscleId =
//         _selectedMuscleId ?? state.musclesState.data?.firstOrNull?.id;
//     if (muscleId == null) return;

//     context.read<PopularTrainingCubit>().doAction(
//           GetExercisesEvent(
//             primeMoverMuscleId: muscleId,
//             difficultyLevelId: levelId,
//           ),
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<PopularTrainingCubit, PopularTrainingStates>(
//       builder: (context, state) {
//         _fetchExercisesIfReady(state);

//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ── Header ──────────────────────────────────────────────────────
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Popular Training',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () =>
//                       Navigator.pushNamed(context, Routes.workouts),
//                   child: Text(
//                     'See All',
//                     style: TextStyle(
//                       color: AppColors.primaryColor,
//                       fontSize: 14,
//                       decoration: TextDecoration.underline,
//                       decorationColor: AppColors.primaryColor,
//                       decorationThickness: 2,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),

//             // ── Level Chips ──────────────────────────────────────────────────
//             _buildLevelsChips(state),
//             const SizedBox(height: 12),

//             // ── Exercise Cards ───────────────────────────────────────────────
//             _buildExerciseCards(state),
//           ],
//         );
//       },
//     );
//   }

//   // ─── Levels Chips ──────────────────────────────────────────────────────────

//   Widget _buildLevelsChips(PopularTrainingStates state) {
//     final levelsState = state.levelsState;

//     if (levelsState.isLoading == true) {
//       return _LevelsShimmer();
//     }

//     if (levelsState.data == null || levelsState.data!.isEmpty) {
//       return const SizedBox.shrink();
//     }

//     final levels = levelsState.data!;
//     final selectedId = _selectedLevelId ?? levels.firstOrNull?.id;

//     return SizedBox(
//       height: 36,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         itemCount: levels.length,
//         separatorBuilder: (_, _) => const SizedBox(width: 8),
//         itemBuilder: (context, index) {
//           final level = levels[index];
//           final isSelected = level.id == selectedId;

//           return GestureDetector(
//             onTap: () => _onLevelSelected(level.id, state),
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               decoration: BoxDecoration(
//                 color: isSelected
//                     ? AppColors.primaryColor
//                     : Colors.white.withOpacity(0.08),
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(
//                   color: isSelected
//                       ? AppColors.primaryColor
//                       : Colors.white.withOpacity(0.15),
//                   width: 1,
//                 ),
//               ),
//               child: Text(
//                 level.name,
//                 style: TextStyle(
//                   color: isSelected ? Colors.white : Colors.white70,
//                   fontSize: 13,
//                   fontWeight:
//                       isSelected ? FontWeight.bold : FontWeight.normal,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // ─── Exercise Cards ────────────────────────────────────────────────────────

//   Widget _buildExerciseCards(PopularTrainingStates state) {
//     final exercisesState = state.exercisesState;

//     if (exercisesState.isLoading == true) {
//       return _ExercisesShimmer();
//     }

//     if (exercisesState.error != null) {
//       return Center(
//         child: Text(
//           exercisesState.error.toString(),
//           style: const TextStyle(color: Colors.red, fontSize: 12),
//         ),
//       );
//     }

//     if (exercisesState.data == null || exercisesState.data!.isEmpty) {
//       return const SizedBox(
//         height: 190,
//         child: Center(
//           child: Text(
//             'No exercises found',
//             style: TextStyle(color: Colors.white54),
//           ),
//         ),
//       );
//     }

//     final exercises = exercisesState.data!;

//     return SizedBox(
//       height: 190,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         itemCount: exercises.length,
//         separatorBuilder: (_, _) => const SizedBox(width: 14),
//         itemBuilder: (context, index) =>
//             _ExerciseCard(exercise: exercises[index]),
//       ),
//     );
//   }
// }

// // ─── Exercise Card ────────────────────────────────────────────────────────────

// class _ExerciseCard extends StatelessWidget {
//   final ExerciseEntity exercise;

//   const _ExerciseCard({required this.exercise});

//   Color get _levelColor {
//     switch (exercise.difficultyLevel.toLowerCase()) {
//       case 'beginner':
//         return const Color(0xFFFF8C00);
//       case 'intermediate':
//         return const Color(0xFF4CAF50);
//       case 'advanced':
//         return const Color(0xFFF44336);
//       default:
//         return const Color(0xFFFF8C00);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(18),
//       child: Stack(
//         children: [
//           // ── Background ───────────────────────────────────────────────────
//           Container(
//             width: 170,
//             height: 190,
//             color: const Color(0xFF1E1E1E),
//             child: const Icon(
//               Icons.fitness_center,
//               color: Colors.orange,
//               size: 40,
//             ),
//           ),

//           // ── Dark Gradient Overlay ────────────────────────────────────────
//           Container(
//             width: 170,
//             height: 190,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Colors.black.withOpacity(0.1),
//                   Colors.black.withOpacity(0.80),
//                 ],
//               ),
//             ),
//           ),

//           // ── Content ──────────────────────────────────────────────────────
//           Positioned(
//             bottom: 12,
//             left: 12,
//             right: 12,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   exercise.exercise,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 13,
//                     height: 1.3,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Row(
//                   children: [
//                     Text(
//                       exercise.primaryEquipment,
//                       style: const TextStyle(
//                         color: Colors.white70,
//                         fontSize: 11,
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 8,
//                         vertical: 3,
//                       ),
//                       decoration: BoxDecoration(
//                         color: _levelColor.withOpacity(0.2),
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(
//                           color: _levelColor.withOpacity(0.6),
//                           width: 0.8,
//                         ),
//                       ),
//                       child: Text(
//                         exercise.difficultyLevel,
//                         style: TextStyle(
//                           color: _levelColor,
//                           fontSize: 11,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ─── Shimmers ─────────────────────────────────────────────────────────────────

// class _LevelsShimmer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 36,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         itemCount: 4,
//         separatorBuilder: (_, _) => const SizedBox(width: 8),
//         itemBuilder: (_, _) => Container(
//           width: 70,
//           height: 36,
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.08),
//             borderRadius: BorderRadius.circular(20),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _ExercisesShimmer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 190,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         itemCount: 3,
//         separatorBuilder: (_, _) => const SizedBox(width: 14),
//         itemBuilder: (_, _) => Container(
//           width: 170,
//           height: 190,
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.08),
//             borderRadius: BorderRadius.circular(18),
//           ),
//         ),
//       ),
//     );
//   }
// }















// import 'package:fitness_app/core/resources/app_colors.dart';
// import 'package:fitness_app/core/routes/app_route.dart';
// import 'package:flutter/material.dart';

// class PopularTrainingSectionWidget extends StatelessWidget {
//   const PopularTrainingSectionWidget({super.key});

//   static const List<_TrainingItem> _items = [
//     _TrainingItem(
//       title: 'Exercises That\nStrengthen Your Chest',
//       tasks: 24,
//       level: 'Beginner',
//       levelColor: Color(0xFFFF8C00),
//       imageUrl:
//           'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400',
//     ),
//     _TrainingItem(
//       title: 'Exercises That\nStrengthen Your Back',
//       tasks: 36,
//       level: 'Interm.',
//       levelColor: Color(0xFF4CAF50),
//       imageUrl:
//           'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=400',
//     ),
//     _TrainingItem(
//       title: 'Full Body\nIntense Workout',
//       tasks: 18,
//       level: 'Advanced',
//       levelColor: Color(0xFFF44336),
//       imageUrl:
//           'https://images.unsplash.com/photo-1549060279-7e168fcee0c2?w=400',
//     ),
//     _TrainingItem(
//       title: 'Core & Abs\nDaily Routine',
//       tasks: 20,
//       level: 'Beginner',
//       levelColor: Color(0xFFFF8C00),
//       imageUrl:
//           'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=400',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               'Popular Training',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, Routes.workouts);
//               },
//               child: Text(
//                 'See All',
//                 style: TextStyle(
//                   color: AppColors.primaryColor,
//                   fontSize: 14,
//                   decoration: TextDecoration.underline,
//                   decorationColor: AppColors.primaryColor,
//                   decorationThickness: 2,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         SizedBox(
//           height: 190,
//           child: ListView.separated(
//             scrollDirection: Axis.horizontal,
//             itemCount: _items.length,
//             separatorBuilder: (_, _) => const SizedBox(width: 14),
//             itemBuilder: (context, index) => _TrainingCard(item: _items[index]),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _TrainingCard extends StatelessWidget {
//   final _TrainingItem item;

//   const _TrainingCard({required this.item});

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(18),
//       child: Stack(
//         children: [
//           // Background image
//           SizedBox(
//             width: 170,
//             height: 190,
//             child: Image.network(
//               item.imageUrl,
//               fit: BoxFit.cover,
//               errorBuilder: (_, _, _) => Container(
//                 color: const Color(0xFF1E1E1E),
//                 child: const Icon(
//                   Icons.fitness_center,
//                   color: Colors.orange,
//                   size: 40,
//                 ),
//               ),
//             ),
//           ),
//           // Dark gradient overlay
//           Container(
//             width: 170,
//             height: 190,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Colors.black.withValues(alpha: 0.1),
//                   Colors.black.withValues(alpha: 0.75),
//                 ],
//               ),
//             ),
//           ),
//           // Content
//           Positioned(
//             bottom: 12,
//             left: 12,
//             right: 12,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   item.title,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 13,
//                     height: 1.3,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Row(
//                   children: [
//                     Text(
//                       '${item.tasks} Tasks',
//                       style: const TextStyle(
//                         color: Colors.white70,
//                         fontSize: 11,
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 8,
//                         vertical: 3,
//                       ),
//                       decoration: BoxDecoration(
//                         color: item.levelColor.withValues(alpha: 0.2),
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(
//                           color: item.levelColor.withValues(alpha: 0.6),
//                           width: 0.8,
//                         ),
//                       ),
//                       child: Text(
//                         item.level,
//                         style: TextStyle(
//                           color: item.levelColor,
//                           fontSize: 11,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _TrainingItem {
//   final String title;
//   final int tasks;
//   final String level;
//   final Color levelColor;
//   final String imageUrl;

//   const _TrainingItem({
//     required this.title,
//     required this.tasks,
//     required this.level,
//     required this.levelColor,
//     required this.imageUrl,
//   });
// }
