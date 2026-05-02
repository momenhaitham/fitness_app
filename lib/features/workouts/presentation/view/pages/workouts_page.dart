import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/features/workouts/presentation/view/widgets/workouts_body.dart';
import 'package:fitness_app/features/workouts/presentation/view_model/cubit/workouts_cubit.dart';
import 'package:fitness_app/features/workouts/presentation/view_model/cubit/workouts_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutsPage extends StatelessWidget {
  const WorkoutsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<WorkoutsCubit>()..doIntent(GetMuscleGroupsIntent()),
      child: const Scaffold(
        backgroundColor: Colors.black, // Dark background as shown in image
        body: WorkoutsBody(),
      ),
    );
  }
}
