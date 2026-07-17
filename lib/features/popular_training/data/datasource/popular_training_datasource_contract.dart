import 'package:fitness_app/features/popular_training/data/models/exercises_response_dto.dart';
import 'package:fitness_app/features/popular_training/data/models/levels_response_dto.dart';
import 'package:fitness_app/features/popular_training/data/models/muscles_response_dto.dart';

abstract class PopularTrainingRemoteDataSource {
  Future<LevelsResponse> getLevels();

  Future<MusclesResponse> getRandomMuscles();

  Future<ExercisesResponse> getExercises({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
  });
}