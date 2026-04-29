
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/home/data/datasourse/home_remote_datasourse_impl.dart';
import 'package:fitness_app/features/home/data/models/mapper.dart';
import 'package:fitness_app/features/home/domian/entities/food_for_you_model.dart';
import 'package:fitness_app/features/home/domian/entities/recommendation_model.dart';
import 'package:fitness_app/features/home/domian/entities/work_out_model.dart';
import 'package:fitness_app/features/home/domian/repository/home_repository_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepositoryContract)
class HomeRepositoryImpl implements HomeRepositoryContract {
  HomeRepositoryImpl(HomeRemoteDataSourceContract homeRemoteDataSource)
      : _homeRemoteDataSource = homeRemoteDataSource;

  final HomeRemoteDataSourceContract _homeRemoteDataSource;

  @override
  Future<BaseResponse<FoodForYouModel>> getFoodData() async {
    final response = await _homeRemoteDataSource.getFoodData();
    return switch (response) {
      SuccessResponse(:final data) =>
        SuccessResponse(data: data.toEntity()),
      ErrorResponse(:final error) =>
        ErrorResponse(error: error),
    };
  }

  @override
  Future<BaseResponse<WorkOutModel>> getWorkOutData() async {
    final response = await _homeRemoteDataSource.getWorkOutData();
    return switch (response) {
      SuccessResponse(:final data) =>
        SuccessResponse(data: data.toEntity()),
      ErrorResponse(:final error) =>
        ErrorResponse(error: error),
    };
  }

  @override
  Future<BaseResponse<RecommendationModel>> getRecommendationData() async {
    final response = await _homeRemoteDataSource.getRecommendationData();
    return switch (response) {
      SuccessResponse(:final data) =>
        SuccessResponse(data: data.toEntity()),
      ErrorResponse(:final error) =>
        ErrorResponse(error: error),
    };
  }
}