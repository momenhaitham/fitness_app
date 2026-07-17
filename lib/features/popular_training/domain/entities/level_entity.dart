import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class LevelEntity extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final String name;

  const LevelEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}