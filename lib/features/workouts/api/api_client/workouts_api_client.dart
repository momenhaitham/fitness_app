import 'package:dio/dio.dart';
import 'package:fitness_app/core/endpoint/app_endpoint.dart';
import 'package:fitness_app/features/workouts/data/models/muscle_group_model.dart';
import 'package:fitness_app/features/workouts/data/models/muscle_group_by_id_response.dart';
import 'package:fitness_app/features/workouts/data/models/muscles_group_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'workouts_api_client.g.dart';

@RestApi(baseUrl: AppEndPoint.baseUrl)
@lazySingleton
abstract class WorkoutsApiClient {
  @factoryMethod
  factory WorkoutsApiClient(Dio dio) = _WorkoutsApiClient;

  @GET(AppEndPoint.workouts)
  Future<MusclesGroupResponse> getAllMuscleGroups();

  @GET('${AppEndPoint.musclesGroupById}/{id}')
  Future<MuscleGroupByIdResponse> getMusclesByGroupId(
    @Path('id') String? muscleGroupId,
  );
}
