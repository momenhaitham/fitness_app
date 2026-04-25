import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/exercise/domain/entities/get_all_levels_model.dart';
import 'package:fitness_app/features/exercise/domain/repositories/exercise_repository.dart';
import 'package:injectable/injectable.dart';


@injectable
class GetAllLevelsUsecase {
  ExerciseRepository exerciseRepository;
  GetAllLevelsUsecase(this.exerciseRepository);

  Future<BaseResponse<GetAllLevelsModel>?> invoke(String? currentLocale)async {
    return await exerciseRepository.getAllLevels(currentLocale);
  }
}