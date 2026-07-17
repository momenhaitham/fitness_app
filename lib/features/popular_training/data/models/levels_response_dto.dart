import 'package:fitness_app/features/popular_training/data/models/levels_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'levels_response_dto.g.dart';

@JsonSerializable()
class LevelsResponse {
  final String message;
  final List<Level> levels;

  LevelsResponse({
    required this.message,
    required this.levels,
  });

  factory LevelsResponse.fromJson(Map<String, dynamic> json) =>
      _$LevelsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LevelsResponseToJson(this);
}