import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/workouts/data/datasources/workouts_remote_data_source_contract.dart';
import 'package:fitness_app/features/workouts/domain/entities/muscle_group_by_id_response_entity.dart';
import 'package:fitness_app/features/workouts/domain/entities/muscle_group_entity.dart';
import 'package:fitness_app/features/workouts/domain/repositories/workouts_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: WorkoutRepository)
class WorkoutsRepositoryImpl implements WorkoutRepository {
  final WorkoutRemoteDataSourceContract _remoteDataSource;

  WorkoutsRepositoryImpl(this._remoteDataSource);
  
  @override
  Future<BaseResponse<List<MuscleGroupEntity>>> getAllMuscleGroups() async {
    return await _remoteDataSource.fetchWorkouts();
  }

  @override
  Future<BaseResponse<MuscleGroupByIdResponseEntity>> getMusclesByGroupId(
    String muscleGroupId,
  ) async {
    return await _remoteDataSource.getMusclesByGroupId(muscleGroupId);
  }
}