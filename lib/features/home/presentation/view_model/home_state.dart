import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/features/home/domian/entities/food_for_you_model.dart';
import 'package:fitness_app/features/home/domian/entities/recommendation_model.dart';
import 'package:fitness_app/features/home/domian/entities/work_out_model.dart';

// class HomeStates {
//   final BaseState<FoodForYouModel> foodState;
//   final BaseState<WorkOutModel> workOutState;
//   final BaseState<RecommendationModel> recommendationState;

//   const HomeStates({
//     required this.foodState,
//     required this.workOutState,
//     required this.recommendationState,
//   });

//   factory HomeStates.initial() {
//     return const HomeStates(
//       foodState: BaseState.initial(),
//       workOutState: BaseState.initial(),
//       recommendationState: BaseState.initial(),
//     );
//   }

//   HomeStates copyWith({
//     BaseState<FoodForYouModel>? foodState,
//     BaseState<WorkOutModel>? workOutState,
//     BaseState<RecommendationModel>? recommendationState,
//   }) {
//     return HomeStates(
//       foodState: foodState ?? this.foodState,
//       workOutState: workOutState ?? this.workOutState,
//       recommendationState: recommendationState ?? this.recommendationState,
//     );
//   }
// }




class HomeStates {
  final BaseState<FoodForYouModel> foodState;
  final BaseState<WorkOutModel> workOutState;
  final BaseState<RecommendationModel> recommendationState;

  const HomeStates({
    required this.foodState,
    required this.workOutState,
    required this.recommendationState,
  });

  factory HomeStates.initial() {
    return HomeStates(
      foodState: BaseState.initial(),
      workOutState: BaseState.initial(),
      recommendationState: BaseState.initial(),
    );
  }

  HomeStates copyWith({
    BaseState<FoodForYouModel>? foodState,
    BaseState<WorkOutModel>? workOutState,
    BaseState<RecommendationModel>? recommendationState,
  }) {
    return HomeStates(
      foodState: foodState ?? this.foodState,
      workOutState: workOutState ?? this.workOutState,
      recommendationState: recommendationState ?? this.recommendationState,
    );
  }
}