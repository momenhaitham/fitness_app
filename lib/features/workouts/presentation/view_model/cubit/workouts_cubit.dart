import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/config/base_state/custom_cubit.dart';
import 'package:fitness_app/features/workouts/domain/entities/muscle_group_entity.dart';
import 'package:fitness_app/features/workouts/domain/use_cases/get_muscles_group_by_id_use_case.dart';
import 'package:fitness_app/features/workouts/domain/use_cases/get_muscles_group_use_case.dart';
import 'package:fitness_app/features/workouts/presentation/view_model/cubit/workouts_events.dart';
import 'package:fitness_app/features/workouts/presentation/view_model/cubit/workouts_intent.dart';
import 'package:fitness_app/features/workouts/presentation/view_model/cubit/workouts_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class WorkoutsCubit extends CustomCubit<WorkoutsEvent, WorkoutsState> {
  final GetMusclesGroupUseCase _getMusclesGroupUseCase;
  final GetMusclesGroupByIdUseCase _getMusclesGroupByIdUseCase;

  WorkoutsCubit(
    this._getMusclesGroupUseCase,
    this._getMusclesGroupByIdUseCase,
  ) : super(WorkoutsState(
          muscleGroupsState: BaseState(),
          workoutsState: BaseState(),
        ));

  void doIntent(WorkoutsIntent intent) {
    switch (intent) {
      case GetMuscleGroupsIntent():
        _fetchMuscleGroups();
        break;
      case GetWorkoutsByGroupIntent():
        _fetchWorkoutsByGroup(intent.muscleGroupId);
        break;
    }
  }

  Future<void> _fetchMuscleGroups() async {
    emit(state.copyWith(muscleGroupsState: BaseState(isLoading: true)));
    final response = await _getMusclesGroupUseCase.invoke();
    
    emit(state.copyWith(muscleGroupsState: response.toBaseState()));
    
    if (response is SuccessResponse<List<MuscleGroupEntity>>) {
      final list = response.data;
      if (list.isNotEmpty) {
        doIntent(GetWorkoutsByGroupIntent(list.first.id!));
      }
    }
  }

  Future<void> _fetchWorkoutsByGroup(String groupId) async {
    emit(state.copyWith(
      workoutsState: BaseState(isLoading: true),
      selectedGroupId: groupId,
    ));
    final response = await _getMusclesGroupByIdUseCase.call(groupId);
    
    emit(state.copyWith(workoutsState: response.toBaseState()));
  }
}
