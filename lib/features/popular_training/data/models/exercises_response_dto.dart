import 'package:fitness_app/features/popular_training/data/models/exercise_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercises_response_dto.g.dart';

@JsonSerializable()
class ExercisesResponse {
  final String message;
  final int totalExercises;
  final int totalPages;
  final int currentPage;
  final List<Exercise> exercises;

  ExercisesResponse({
    required this.message,
    required this.totalExercises,
    required this.totalPages,
    required this.currentPage,
    required this.exercises,
  });

  factory ExercisesResponse.fromJson(Map<String, dynamic> json) =>
      _$ExercisesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ExercisesResponseToJson(this);
}