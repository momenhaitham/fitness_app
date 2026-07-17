import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/popular_training/domain/entities/exercise_entity.dart';
import 'package:fitness_app/features/popular_training/domain/repository/popular_training_repository_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetExercisesUseCase {
  final PopularTrainingRepository _repository;

  GetExercisesUseCase(this._repository);

  Future<BaseResponse<List<ExerciseEntity>>> call({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
  }) {
    return _repository.getExercises(
      primeMoverMuscleId: primeMoverMuscleId,
      difficultyLevelId: difficultyLevelId,
    );
  }
}