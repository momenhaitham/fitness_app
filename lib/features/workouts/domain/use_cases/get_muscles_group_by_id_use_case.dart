import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/workouts/domain/entities/muscle_group_by_id_response_entity.dart';
import 'package:fitness_app/features/workouts/domain/repositories/workouts_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMusclesGroupByIdUseCase {
  final WorkoutRepository _workoutRepository;

  GetMusclesGroupByIdUseCase(this._workoutRepository);

  Future<BaseResponse<MuscleGroupByIdResponseEntity>> call(
    String muscleGroupId,
  ) async {
    return await _workoutRepository.getMusclesByGroupId(muscleGroupId);
  }
}