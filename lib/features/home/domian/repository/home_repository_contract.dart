import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/home/domian/entities/food_for_you_model.dart';
import 'package:fitness_app/features/home/domian/entities/recommendation_model.dart';
import 'package:fitness_app/features/home/domian/entities/work_out_model.dart';

abstract class HomeRepositoryContract {

  Future<BaseResponse<RecommendationModel>> getRecommendationData();
  Future<BaseResponse<FoodForYouModel>> getFoodData();
  Future<BaseResponse<WorkOutModel>> getWorkOutData();
}