import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/home/data/models/food_for_you_response_dto.dart';
import 'package:fitness_app/features/home/data/models/recommendation_to_day_response_dto.dart';
import 'package:fitness_app/features/home/data/models/work_out_response_dto.dart';


abstract class HomeRemoteDataSourceContract {
  Future<BaseResponse<FoodForYouResponseDto>> getFoodData();
  Future<BaseResponse<WorkOutResponseDto>> getWorkOutData();
  Future<BaseResponse<RecommendationToDayResponseDto>> getRecommendationData();
}