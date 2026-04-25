import 'package:fitness_app/config/api_utils/api_utils.dart';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/exercise/api/api_client/exercise_api_client.dart';
import 'package:fitness_app/features/exercise/data/datasources/exercise_remote_data_source_contract.dart';
import 'package:fitness_app/features/exercise/data/models/get_all_levels_dto.dart';
import 'package:fitness_app/features/exercise/data/models/get_exercises_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExerciseRemoteDataSourceContract)
class ExerciseRemoteDataSourceImpl implements ExerciseRemoteDataSourceContract {
  ExerciseApiClient exerciseApiClient;
  ExerciseRemoteDataSourceImpl(this.exerciseApiClient);

  @override
  Future<BaseResponse<GetAllLevelsDto>> getAllLevels({
    String? currentLocale,
  }) async {
    return await executeApi(
      () => exerciseApiClient.getAllLevels(currentLocale),
    );
  }

  @override
  Future<BaseResponse<GetExercisesDto>> getExercises({
    String? currentLocale,
    String? muscleId,
    String? difficultyLevelId,
  }) async {
    return await executeApi(
      () => exerciseApiClient.getExercises(
        currentLocale: currentLocale,
        muscleId: muscleId,
        difficultyLevelId: difficultyLevelId,
      ),
    );
  }
}
