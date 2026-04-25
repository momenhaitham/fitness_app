import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/exercise/domain/entities/get_exercises_model.dart';
import 'package:fitness_app/features/exercise/domain/repositories/exercise_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetExercisesUsecase {
  ExerciseRepository exerciseRepository;
  GetExercisesUsecase(this.exerciseRepository);

  Future<BaseResponse<GetExercisesModel>?> invoke({String? currentLocale,String? muscleId,String? difficultyLevelId})async {
    return await exerciseRepository.getExercises(currentLocale,muscleId,difficultyLevelId);
  }
}