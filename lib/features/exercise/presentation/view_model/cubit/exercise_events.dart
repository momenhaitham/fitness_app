import 'package:fitness_app/features/exercise/domain/entities/exercise_model.dart';

sealed class ExerciseEvents {}

class GetExercisesEvent extends ExerciseEvents {
  final String? currentLocale;
  final String? muscleId;
  final String? difficultyLevelId;
  GetExercisesEvent({this.currentLocale, this.muscleId, this.difficultyLevelId});
}

class GetAllLevelsEvent extends ExerciseEvents {
  final String? currentLocale;
  GetAllLevelsEvent({this.currentLocale});
}

class LaunchVideoEvent extends ExerciseEvents {
  final String videoId;
  final ExerciseModel exerciseModel;
  LaunchVideoEvent({required this.videoId,required this.exerciseModel});
}

class InitScreenEvent extends ExerciseEvents {
  final String? currentLocale;
  final String? muscleId;
  InitScreenEvent({this.currentLocale, this.muscleId});
}
