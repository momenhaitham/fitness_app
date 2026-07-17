import 'dart:developer';

import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/features/popular_training/domain/entities/exercise_entity.dart';
import 'package:fitness_app/features/popular_training/domain/entities/level_entity.dart';
import 'package:fitness_app/features/popular_training/domain/entities/muscle_entity.dart';
import 'package:fitness_app/features/popular_training/domain/usecase/get_exercises_usecase.dart';
import 'package:fitness_app/features/popular_training/domain/usecase/get_levels_usecase.dart';
import 'package:fitness_app/features/popular_training/domain/usecase/get_random_muscles_usecase.dart';
import 'package:fitness_app/features/popular_training/presentation/view_model/popular_training_event.dart';
import 'package:fitness_app/features/popular_training/presentation/view_model/popular_training_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PopularTrainingCubit extends Cubit<PopularTrainingStates> {
  final GetLevelsUseCase _getLevelsUseCase;
  final GetRandomMusclesUseCase _getRandomMusclesUseCase;
  final GetExercisesUseCase _getExercisesUseCase;

  PopularTrainingCubit(
    this._getLevelsUseCase,
    this._getRandomMusclesUseCase,
    this._getExercisesUseCase,
  ) : super(PopularTrainingStates.initial());

  // ================== EVENTS ==================

  void doAction(PopularTrainingEvents event) {
    switch (event) {
      case GetAllPopularTrainingDataEvent():
        _getAllData();
      case GetLevelsEvent():
        _getLevels();
      case GetRandomMusclesEvent():
        _getRandomMuscles();
      case GetExercisesEvent(:final primeMoverMuscleId, :final difficultyLevelId):
        _getExercises(
          primeMoverMuscleId: primeMoverMuscleId,
          difficultyLevelId: difficultyLevelId,
        );
    }
  }

  // ================== ALL ==================

  Future<void> _getAllData() async {
    await Future.wait([
      _getLevels(),
      _getRandomMuscles(),
    ]);
  }

  // ================== LEVELS ==================

  Future<void> _getLevels() async {
    emit(state.copyWith(levelsState: BaseState(isLoading: true)));

    final BaseResponse<List<LevelEntity>> response =
        await _getLevelsUseCase();

    switch (response) {
      case SuccessResponse(:final data):
        emit(state.copyWith(levelsState: BaseState(data: data)));
      case ErrorResponse(:final error):
        log(error.toString());
        emit(state.copyWith(levelsState: BaseState(error: error)));
    }
  }

  // ================== MUSCLES ==================

  Future<void> _getRandomMuscles() async {
    emit(state.copyWith(musclesState: BaseState(isLoading: true)));

    final BaseResponse<List<MuscleEntity>> response =
        await _getRandomMusclesUseCase();

    switch (response) {
      case SuccessResponse(:final data):
        emit(state.copyWith(musclesState: BaseState(data: data)));
      case ErrorResponse(:final error):
        log(error.toString());
        emit(state.copyWith(musclesState: BaseState(error: error)));
    }
  }

  // ================== EXERCISES ==================

  Future<void> _getExercises({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
  }) async {
    emit(state.copyWith(exercisesState: BaseState(isLoading: true)));

    final BaseResponse<List<ExerciseEntity>> response =
        await _getExercisesUseCase(
      primeMoverMuscleId: primeMoverMuscleId,
      difficultyLevelId: difficultyLevelId,
    );

    switch (response) {
      case SuccessResponse(:final data):
        emit(state.copyWith(exercisesState: BaseState(data: data)));
      case ErrorResponse(:final error):
        log(error.toString());
        emit(state.copyWith(exercisesState: BaseState(error: error)));
    }
  }

  @override
  void emit(PopularTrainingStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}