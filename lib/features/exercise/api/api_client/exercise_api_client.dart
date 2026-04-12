import 'package:dio/dio.dart';
import 'package:fitness_app/core/endpoint/app_endpoint.dart';
import 'package:fitness_app/features/exercise/data/models/get_all_levels_dto.dart';
import 'package:fitness_app/features/exercise/data/models/get_exercises_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'exercise_api_client.g.dart';

@injectable
@RestApi()
abstract class ExerciseApiClient {
  @factoryMethod
  factory ExerciseApiClient(Dio dio) = _ExerciseApiClient;

  @GET(AppEndPoint.levels)
  Future<GetAllLevelsDto> getAllLevels(@Header("accept-language") String? currentLocale);

  @GET(AppEndPoint.exercises)
  Future<GetExercisesDto> getExercises({
  @Header("Accept-Language") String? currentLocale,
  @Query("primeMoverMuscleId") String? muscleId,
  @Query("difficultyLevelId") String? difficultyLevelId}
  );

}
