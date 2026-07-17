import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/popular_training/domain/entities/muscle_entity.dart';
import 'package:fitness_app/features/popular_training/domain/repository/popular_training_repository_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRandomMusclesUseCase {
  final PopularTrainingRepository _repository;

  GetRandomMusclesUseCase(this._repository);

  Future<BaseResponse<List<MuscleEntity>>> call() {
    return _repository.getRandomMuscles();
  }
}