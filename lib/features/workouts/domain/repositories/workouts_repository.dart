import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/workouts/domain/entities/muscle_group_by_id_response_entity.dart';
import 'package:fitness_app/features/workouts/domain/entities/muscle_group_entity.dart';

abstract class WorkoutRepository {
  Future<BaseResponse<List<MuscleGroupEntity>>> getAllMuscleGroups();

  Future<BaseResponse<MuscleGroupByIdResponseEntity>> getMusclesByGroupId(
    String muscleGroupId,
  );
}