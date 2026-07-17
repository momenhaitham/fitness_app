import 'package:dio/dio.dart';
import 'package:fitness_app/core/endpoint/app_endpoint.dart';
import 'package:fitness_app/features/popular_training/data/models/exercises_response_dto.dart';
import 'package:fitness_app/features/popular_training/data/models/levels_response_dto.dart';

import 'package:fitness_app/features/popular_training/data/models/muscles_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'popular_training_api_client.g.dart';

@injectable
@RestApi()
abstract class PopularTrainingApiClient {
  @factoryMethod
  factory PopularTrainingApiClient(Dio dio) = _PopularTrainingApiClient;

  @GET(AppEndPoint.randomPrimeMoverMuscles)
  Future<MusclesResponse> getRandomPrimeMoverMuscles();

  @GET(AppEndPoint.levels)
  Future<LevelsResponse> getLevels();

  @GET(AppEndPoint.getExercisesByPrimeMoverMuscleAndDifficultyLevel)
  Future<ExercisesResponse> getExercises({
    @Query('primeMoverMuscleId') required String primeMoverMuscleId,
    @Query('difficultyLevelId') required String difficultyLevelId,
  });
}