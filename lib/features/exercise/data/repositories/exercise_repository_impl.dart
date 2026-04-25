import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/exercise/data/datasources/exercise_remote_data_source_contract.dart';
import 'package:fitness_app/features/exercise/data/models/get_all_levels_dto.dart';
import 'package:fitness_app/features/exercise/data/models/get_exercises_dto.dart';
import 'package:fitness_app/features/exercise/domain/entities/get_all_levels_model.dart';
import 'package:fitness_app/features/exercise/domain/entities/get_exercises_model.dart';
import 'package:fitness_app/features/exercise/domain/repositories/exercise_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExerciseRepository)
class ExerciseRepositoryImpl implements ExerciseRepository {
  ExerciseRemoteDataSourceContract exerciseRemoteDataSourceContract;

  ExerciseRepositoryImpl(this.exerciseRemoteDataSourceContract);
  @override
  Future<BaseResponse<GetAllLevelsModel>?> getAllLevels(
    String? currentLocale,
  ) async {
    var response = await exerciseRemoteDataSourceContract.getAllLevels(
      currentLocale: currentLocale,
    );
    switch (response) {
      case null:
        return ErrorResponse<GetAllLevelsModel>(
          error: Exception("Something went Wronmg"),
        );
      case SuccessResponse<GetAllLevelsDto>():
        return SuccessResponse<GetAllLevelsModel>(
          data: response.data.toDomain(),
        );
      case ErrorResponse<GetAllLevelsDto>():
        return ErrorResponse<GetAllLevelsModel>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<GetExercisesModel>?> getExercises(String? currentLocale,String? muscleId,String? difficultyLevelId,) async {
    var response =await exerciseRemoteDataSourceContract.getExercises(currentLocale: currentLocale,muscleId: muscleId,difficultyLevelId: difficultyLevelId,);

    switch(response){

      case null:
        return ErrorResponse<GetExercisesModel>(
          error: Exception("Something went Wronmg"),
        );
      case SuccessResponse<GetExercisesDto>():
        return SuccessResponse<GetExercisesModel>(
          data: response.data.toModel(),
        );
      case ErrorResponse<GetExercisesDto>():
        return ErrorResponse<GetExercisesModel>(error: response.error);
    }
  }
}
