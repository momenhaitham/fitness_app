import 'package:fitness_app/features/exercise/domain/entities/level_model.dart';

class GetAllLevelsModel {
  String? message;
  String? error;
  List<LevelModel>? levels;

  GetAllLevelsModel({this.message, this.error, this.levels});
}