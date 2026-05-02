import 'package:fitness_app/config/api_utils/api_utils.dart';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/workouts/api/api_client/workouts_api_client.dart';
import 'package:fitness_app/features/workouts/data/datasources/workouts_remote_data_source_contract.dart';
import 'package:fitness_app/features/workouts/data/models/muscle_group_by_id_response.dart';
import 'package:fitness_app/features/workouts/data/models/muscle_group_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: WorkoutRemoteDataSourceContract)
class WorkoutsRemoteDataSourceImpl implements WorkoutRemoteDataSourceContract {
  final WorkoutsApiClient _client;

  WorkoutsRemoteDataSourceImpl(this._client);

  @override
  Future<BaseResponse<List<MuscleGroupModel>>> fetchWorkouts() {
    return executeApi(() async {
      final response = await _client.getAllMuscleGroups();
      return response.musclesGroup ?? [];
    });
  }

  @override
  Future<BaseResponse<MuscleGroupByIdResponse>> getMusclesByGroupId(
    String muscleGroupId,
  ) {
    return executeApi(() => _client.getMusclesByGroupId(muscleGroupId));
  }
}