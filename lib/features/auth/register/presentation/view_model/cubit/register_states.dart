
import 'package:fitness_app/config/base_state/base_state.dart';

class RegisterStates {
  BaseState<int>? registerState =BaseState(data: 0);
  RegisterStates({this.registerState});
  RegisterStates copyWith({BaseState<int>? newRegisterState}) {
    return RegisterStates(
      registerState: newRegisterState ?? registerState,
    );
  }
  
}

