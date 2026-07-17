import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/features/popular_training/domain/entities/exercise_entity.dart';
import 'package:fitness_app/features/popular_training/domain/entities/level_entity.dart';
import 'package:fitness_app/features/popular_training/domain/entities/muscle_entity.dart';

class PopularTrainingStates {
  final BaseState<List<LevelEntity>> levelsState;
  final BaseState<List<MuscleEntity>> musclesState;
  final BaseState<List<ExerciseEntity>> exercisesState;

  const PopularTrainingStates({
    required this.levelsState,
    required this.musclesState,
    required this.exercisesState,
  });

  factory PopularTrainingStates.initial() {
    return PopularTrainingStates(
      levelsState: BaseState.initial(),
      musclesState: BaseState.initial(),
      exercisesState: BaseState.initial(),
    );
  }

  PopularTrainingStates copyWith({
    BaseState<List<LevelEntity>>? levelsState,
    BaseState<List<MuscleEntity>>? musclesState,
    BaseState<List<ExerciseEntity>>? exercisesState,
  }) {
    return PopularTrainingStates(
      levelsState: levelsState ?? this.levelsState,
      musclesState: musclesState ?? this.musclesState,
      exercisesState: exercisesState ?? this.exercisesState,
    );
  }
}