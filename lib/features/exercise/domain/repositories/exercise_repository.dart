import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/exercise/domain/entities/get_all_levels_model.dart';
import 'package:fitness_app/features/exercise/domain/entities/get_exercises_model.dart';

abstract class ExerciseRepository {
  Future<BaseResponse<GetExercisesModel>?> getExercises(String? currentLocale, String? muscleId, String? difficultyLevelId);
  Future<BaseResponse<GetAllLevelsModel>?> getAllLevels(String? currentLocale);
}