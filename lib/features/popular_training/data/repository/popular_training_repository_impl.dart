import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/popular_training/data/datasource/popular_training_datasource_contract.dart';
import 'package:fitness_app/features/popular_training/domain/entities/exercise_entity.dart';
import 'package:fitness_app/features/popular_training/domain/entities/level_entity.dart';
import 'package:fitness_app/features/popular_training/domain/entities/muscle_entity.dart';
import 'package:fitness_app/features/popular_training/domain/repository/popular_training_repository_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PopularTrainingRepository)
class PopularTrainingRepositoryImpl implements PopularTrainingRepository {
  final PopularTrainingRemoteDataSource _remoteDataSource;

  PopularTrainingRepositoryImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<List<LevelEntity>>> getLevels() async {
    try {
      final response = await _remoteDataSource.getLevels();
      final levels = response.levels
          .map(
            (dto) => LevelEntity(
              id: dto.id,
              name: dto.name,
            ),
          )
          .toList();
      return SuccessResponse(data: levels);
    } on Exception catch (e) {
      return ErrorResponse(error: e);
    }
  }

  @override
  Future<BaseResponse<List<MuscleEntity>>> getRandomMuscles() async {
    try {
      final response = await _remoteDataSource.getRandomMuscles();
      final muscles = response.muscles
          .map(
            (dto) => MuscleEntity(
              id: dto.id,
              name: dto.name,
              image: dto.image,
            ),
          )
          .toList();
      return SuccessResponse(data: muscles);
    } on Exception catch (e) {
      return ErrorResponse(error: e);
    }
  }

  @override
  Future<BaseResponse<List<ExerciseEntity>>> getExercises({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
  }) async {
    try {
      final response = await _remoteDataSource.getExercises(
        primeMoverMuscleId: primeMoverMuscleId,
        difficultyLevelId: difficultyLevelId,
      );
      final exercises = response.exercises
          .map(
            (dto) => ExerciseEntity(
              id: dto.id,
              exercise: dto.exercise,
              shortYoutubeDemonstration: dto.shortYoutubeDemonstration,
              inDepthYoutubeExplanation: dto.inDepthYoutubeExplanation,
              difficultyLevel: dto.difficultyLevel,
              targetMuscleGroup: dto.targetMuscleGroup,
              primeMoverMuscle: dto.primeMoverMuscle,
              secondaryMuscle: dto.secondaryMuscle,
              tertiaryMuscle: dto.tertiaryMuscle,
              primaryEquipment: dto.primaryEquipment,
              primaryItems: dto.primaryItems,
              secondaryEquipment: dto.secondaryEquipment,
              secondaryItems: dto.secondaryItems,
              posture: dto.posture,
              singleOrDoubleArm: dto.singleOrDoubleArm,
              continuousOrAlternatingArms: dto.continuousOrAlternatingArms,
              grip: dto.grip,
              loadPositionEnding: dto.loadPositionEnding,
              continuousOrAlternatingLegs: dto.continuousOrAlternatingLegs,
              footElevation: dto.footElevation,
              combinationExercises: dto.combinationExercises,
              movementPattern1: dto.movementPattern1,
              movementPattern2: dto.movementPattern2,
              movementPattern3: dto.movementPattern3,
              planeOfMotion1: dto.planeOfMotion1,
              planeOfMotion2: dto.planeOfMotion2,
              planeOfMotion3: dto.planeOfMotion3,
              bodyRegion: dto.bodyRegion,
              forceType: dto.forceType,
              mechanics: dto.mechanics,
              laterality: dto.laterality,
              primaryExerciseClassification: dto.primaryExerciseClassification,
              shortYoutubeDemonstrationLink: dto.shortYoutubeDemonstrationLink,
              inDepthYoutubeExplanationLink: dto.inDepthYoutubeExplanationLink,
            ),
          )
          .toList();
      return SuccessResponse(data: exercises);
    } on Exception catch (e) {
      return ErrorResponse(error: e);
    }
  }
}