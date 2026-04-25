import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/features/exercise/domain/entities/exercise_model.dart';
import 'package:fitness_app/features/exercise/domain/entities/get_all_levels_model.dart';
import 'package:fitness_app/features/exercise/domain/entities/get_exercises_model.dart';

class ExerciseStates {
  BaseState<GetExercisesModel>? exercisesState;
  BaseState<GetAllLevelsModel>? levelsState;
  BaseState<ExerciseModel>? videoState;

  ExerciseStates({this.exercisesState, this.levelsState,this.videoState});

  ExerciseStates copyWith({
    BaseState<GetExercisesModel>? newExercisesState,
    BaseState<GetAllLevelsModel>? newLevelsState,
    BaseState<ExerciseModel>? newVideoState
  }) {
    return ExerciseStates(
      exercisesState: newExercisesState ?? exercisesState,
      levelsState: newLevelsState ?? levelsState,
      videoState: newVideoState ?? videoState
    );
  }
}
