import 'package:fitness_app/features/exercise/domain/entities/exercise_model.dart';

class GetExercisesModel {
  int? totalExercises;
  int? totalPages;
  int? currentPage;
  String? error;
  List<ExerciseModel>? exercises;

  GetExercisesModel({
    this.totalExercises,
    this.totalPages,
    this.currentPage,
    this.error,
    this.exercises,
  });
}
