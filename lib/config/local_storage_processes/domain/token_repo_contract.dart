import 'package:fitness_app/config/base_response/base_response.dart';

abstract class TokenRepoContract {
  Future<String?> getToken();
  Future<BaseResponse<bool>> clearToken();
  bool? getRememberMe();
}
