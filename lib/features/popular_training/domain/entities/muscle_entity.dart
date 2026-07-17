import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class MuscleEntity extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String? image;

  const MuscleEntity({
    required this.id,
    required this.name,
    this.image,
  });

  @override
  List<Object?> get props => [id, name, image];
}