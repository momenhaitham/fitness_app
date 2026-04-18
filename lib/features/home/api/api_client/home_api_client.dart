import 'package:dio/dio.dart';
import 'package:fitness_app/core/endpoint/app_endpoint.dart';
import 'package:fitness_app/features/home/data/models/food_for_you_response_dto.dart';
import 'package:fitness_app/features/home/data/models/recommendation_to_day_response_dto.dart';
import 'package:fitness_app/features/home/data/models/work_out_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'home_api_client.g.dart';

@injectable
@RestApi()
abstract class HomeApiClient {
  @factoryMethod
  factory HomeApiClient(Dio dio) = _HomeApiClient;

  @GET(AppEndPoint.recommendationToDay)
   Future<RecommendationToDayResponseDto> getRecommendationData();

  @GET(AppEndPoint.upcomingWorkOut)
   Future<WorkOutResponseDto> getWorkOutData();

  @GET(AppEndPoint.foodForYou)
   Future<FoodForYouResponseDto> getFoodData();
}