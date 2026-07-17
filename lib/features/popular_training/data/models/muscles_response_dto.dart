import 'package:fitness_app/features/popular_training/data/models/muscle_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'muscles_response_dto.g.dart';

@JsonSerializable()
class MusclesResponse {
  final String message;
  final int totalMuscles;
  final List<Muscle> muscles;

  MusclesResponse({
    required this.message,
    required this.totalMuscles,
    required this.muscles,
  });

  factory MusclesResponse.fromJson(Map<String, dynamic> json) =>
      _$MusclesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MusclesResponseToJson(this);
}