import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/popular_training/domain/entities/level_entity.dart';
import 'package:fitness_app/features/popular_training/domain/repository/popular_training_repository_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetLevelsUseCase {
  final PopularTrainingRepository _repository;

  GetLevelsUseCase(this._repository);

  Future<BaseResponse<List<LevelEntity>>> call() {
    return _repository.getLevels();
  }
}