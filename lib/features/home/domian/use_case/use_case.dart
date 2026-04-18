import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/home/domian/entities/food_for_you_model.dart';
import 'package:fitness_app/features/home/domian/entities/recommendation_model.dart';
import 'package:fitness_app/features/home/domian/entities/work_out_model.dart';
import 'package:fitness_app/features/home/domian/repository/home_repository_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeUseCase {
  HomeUseCase(HomeRepositoryContract homeRepository)
    : _homeRepository = homeRepository;

  final HomeRepositoryContract _homeRepository;

  Future<BaseResponse<FoodForYouModel>> callFoodData() => _homeRepository.getFoodData();

  Future<BaseResponse<WorkOutModel>> callWorkOutData() => _homeRepository.getWorkOutData();

  Future<BaseResponse<RecommendationModel>> callRecommendationData() =>
      _homeRepository.getRecommendationData();
}
