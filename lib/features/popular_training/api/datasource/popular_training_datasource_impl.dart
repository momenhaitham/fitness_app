import 'package:fitness_app/features/popular_training/api/api_client/popular_training_api_client.dart';
import 'package:fitness_app/features/popular_training/data/datasource/popular_training_datasource_contract.dart';
import 'package:fitness_app/features/popular_training/data/models/exercises_response_dto.dart';
import 'package:fitness_app/features/popular_training/data/models/levels_response_dto.dart';
import 'package:fitness_app/features/popular_training/data/models/muscles_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PopularTrainingRemoteDataSource)
class PopularTrainingRemoteDataSourceImpl
    implements PopularTrainingRemoteDataSource {
  final PopularTrainingApiClient _apiClient;

  PopularTrainingRemoteDataSourceImpl(this._apiClient);

  @override
  Future<LevelsResponse> getLevels() async {
    return await _apiClient.getLevels();
  }

  @override
  Future<MusclesResponse> getRandomMuscles() async {
    return await _apiClient.getRandomPrimeMoverMuscles();
  }

  @override
  Future<ExercisesResponse> getExercises({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
  }) async {
    return await _apiClient.getExercises(
      primeMoverMuscleId: primeMoverMuscleId,
      difficultyLevelId: difficultyLevelId,
    );
  }
}