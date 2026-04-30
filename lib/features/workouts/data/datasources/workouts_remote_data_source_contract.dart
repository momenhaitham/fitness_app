import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/workouts/data/models/muscle_group_by_id_response.dart';
import 'package:fitness_app/features/workouts/data/models/muscle_group_model.dart';

abstract class WorkoutRemoteDataSourceContract {
  Future<BaseResponse<List<MuscleGroupModel>>> fetchWorkouts();

  Future<BaseResponse<MuscleGroupByIdResponse>> getMusclesByGroupId(
    String muscleGroupId,
  );
}