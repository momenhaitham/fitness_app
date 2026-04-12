import 'package:fitness_app/features/exercise/domain/entities/get_all_levels_model.dart';
import 'package:fitness_app/features/exercise/domain/entities/level_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_levels_dto.g.dart';

@JsonSerializable()
class GetAllLevelsDto {
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "error")
    String? error;
    @JsonKey(name: "levels")
    List<Level>? levels;

    GetAllLevelsDto({
        this.error,
        this.message,
        this.levels,
    });

    GetAllLevelsModel toDomain() => GetAllLevelsModel(
        error: error,
        message: message,
        levels: levels?.map((e) => e.toDomain()).toList(),
    );

    factory GetAllLevelsDto.fromJson(Map<String, dynamic> json) => _$GetAllLevelsDtoFromJson(json);

    Map<String, dynamic> toJson() => _$GetAllLevelsDtoToJson(this);
}

@JsonSerializable()
class Level {
    @JsonKey(name: "_id")
    String? id;
    @JsonKey(name: "name")
    String? name;

    Level({
        this.id,
        this.name,
    });

    LevelModel toDomain() => LevelModel(
        levelId: id,
        levelName: name,
    );

    factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);

    Map<String, dynamic> toJson() => _$LevelToJson(this);
}
