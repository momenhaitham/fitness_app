sealed class PopularTrainingEvents {}

class GetAllPopularTrainingDataEvent extends PopularTrainingEvents {}

class GetLevelsEvent extends PopularTrainingEvents {}

class GetRandomMusclesEvent extends PopularTrainingEvents {}

class GetExercisesEvent extends PopularTrainingEvents {
  final String primeMoverMuscleId;
  final String difficultyLevelId;

  GetExercisesEvent({
    required this.primeMoverMuscleId,
    required this.difficultyLevelId,
  });
}