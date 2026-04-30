sealed class WorkoutsIntent {}

class GetMuscleGroupsIntent extends WorkoutsIntent {}

class GetWorkoutsByGroupIntent extends WorkoutsIntent {
  final String muscleGroupId;
  GetWorkoutsByGroupIntent(this.muscleGroupId);
}
