import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/features/login/domain/entities/user_entity.dart';

class LoginStates {
  BaseState<UserEntity>? loginState = BaseState(data: null);
  
  LoginStates({this.loginState});
  
  LoginStates copyWith({BaseState<UserEntity>? newLoginState}) {
    return LoginStates(
      loginState: newLoginState ?? loginState,
    );
  }
}
