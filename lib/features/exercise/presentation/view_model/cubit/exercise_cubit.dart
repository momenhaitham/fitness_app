import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/config/base_state/custom_cubit.dart';
import 'package:fitness_app/features/exercise/domain/entities/exercise_model.dart';
import 'package:fitness_app/features/exercise/domain/entities/get_all_levels_model.dart';
import 'package:fitness_app/features/exercise/domain/entities/get_exercises_model.dart';
import 'package:fitness_app/features/exercise/domain/use_cases/get_all_levels_usecase.dart';
import 'package:fitness_app/features/exercise/domain/use_cases/get_exercises_usecase.dart';
import 'package:fitness_app/features/exercise/presentation/view_model/cubit/exercise_events.dart';
import 'package:fitness_app/features/exercise/presentation/view_model/cubit/exercise_states.dart';
import 'package:fitness_app/features/exercise/presentation/view_model/cubit/exercise_temp_events.dart';
import 'package:injectable/injectable.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

@injectable
class ExerciseCubit extends CustomCubit<ExerciseTempEvents, ExerciseStates> {
  GetAllLevelsUsecase getAllLevelsUsecase;
  GetExercisesUsecase getExercisesUsecase;
  YoutubePlayerController? youtubeController;
  bool firstTime = true;
  //int? selectedIndex = 0;
  String? selectedLevelId = '';

  ExerciseCubit(this.getAllLevelsUsecase, this.getExercisesUsecase) : super(ExerciseStates());

  void doIntent(ExerciseEvents event) {
    switch (event) {
      case GetExercisesEvent():
        _getExercises(currentLocale: event.currentLocale, muscleId: event.muscleId, difficultyLevelId: event.difficultyLevelId);
      case GetAllLevelsEvent():
        _getLevels(currentLocale: event.currentLocale);
      case LaunchVideoEvent():
        _launchVideo(videoId:event.videoId,exerciseModel:event.exerciseModel );
      case InitScreenEvent():
        _initScreen(currentLocale: event.currentLocale, muscleId: event.muscleId);
    }
  }

  Future<void> _getLevels({String? currentLocale}) async {
    emit(state.copyWith(newLevelsState: BaseState(isLoading: true)));
    final result = await getAllLevelsUsecase.invoke(currentLocale);
    switch (result) {
      case null:
        emit(state.copyWith(newLevelsState: BaseState(isLoading: false, error: Exception("a7a"))));
      case SuccessResponse<GetAllLevelsModel>():
        emit(state.copyWith(newLevelsState: BaseState(isLoading: false, data: result.data)));
      case ErrorResponse<GetAllLevelsModel>():
        emit(state.copyWith(newLevelsState: BaseState(isLoading: false, error: result.error)));
    }
  }

  Future<void> _getExercises({String? currentLocale, String? muscleId, String? difficultyLevelId}) async {
    emit(state.copyWith(newExercisesState: BaseState(isLoading: true)));
    final result = await getExercisesUsecase.invoke(currentLocale: currentLocale, muscleId: muscleId, difficultyLevelId: difficultyLevelId);
    switch (result) {
      case null:
        emit(state.copyWith(newExercisesState: BaseState(isLoading: false, error: Exception("a7a"))));
      case SuccessResponse<GetExercisesModel>():
        emit(state.copyWith(newExercisesState: BaseState(isLoading: false, data: result.data)));
      case ErrorResponse<GetExercisesModel>():
        emit(state.copyWith(newExercisesState: BaseState(isLoading: false, error: result.error)));
    }
  }

  void _initScreen({String? currentLocale, String? muscleId}) async {
    await _getLevels(currentLocale: currentLocale);
    await _getExercises(currentLocale: currentLocale, muscleId: muscleId, difficultyLevelId: state.levelsState?.data?.levels?[0].levelId);
  }

  void _launchVideo({required String videoId,required ExerciseModel exerciseModel}) {
    emit(state.copyWith(newVideoState: BaseState(isLoading: true)));
    if (youtubeController != null) {
      youtubeController!.dispose();
    }
    Future.delayed(Duration(seconds: 1)).then((value) {
      youtubeController = YoutubePlayerController(initialVideoId: videoId, flags: YoutubePlayerFlags(autoPlay: true, mute: true));
      emit(state.copyWith(newVideoState: BaseState(data: exerciseModel, isLoading: false)));
    });
  }

  String getYoutubeVideoId(String url) {
    final uri = Uri.parse(url);

    if (uri.host.contains('youtu.be')) {
      return uri.pathSegments.first;
    }

    if (uri.host.contains('youtube.com')) {
      return uri.queryParameters['v'] ?? '';
    }

    return '';
  }
}
