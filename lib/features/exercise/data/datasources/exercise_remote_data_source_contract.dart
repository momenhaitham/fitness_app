import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/exercise/data/models/get_all_levels_dto.dart';
import 'package:fitness_app/features/exercise/data/models/get_exercises_dto.dart';

abstract class ExerciseRemoteDataSourceContract {
  Future<BaseResponse<GetExercisesDto>?> getExercises(String? currentLocale, String? muscleId, String? difficultyLevelId);
  Future<BaseResponse<GetAllLevelsDto>?> getAllLevels(String? currentLocale);
}