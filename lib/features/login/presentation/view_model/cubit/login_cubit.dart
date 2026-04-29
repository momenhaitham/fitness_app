import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/config/base_state/custom_cubit.dart';
import 'package:fitness_app/features/login/domain/entities/user_entity.dart';
import 'package:fitness_app/features/login/domain/use_cases/login_use_case.dart';
import 'package:fitness_app/features/login/presentation/view_model/cubit/login_events.dart';
import 'package:fitness_app/features/login/presentation/view_model/cubit/login_states.dart';
import 'package:fitness_app/features/login/presentation/view_model/cubit/login_temp_events.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends CustomCubit<LoginTempEvents, LoginStates> {
  LoginCubit(this._loginUseCase) : super(LoginStates());
  
  final LoginUseCase _loginUseCase;
  
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void doIntent(LoginEvents event) {
    switch (event) {
      case Login():
        _login();
      case NavigateToRegisterEvent():
        _navigateToRegister();
      case ShowMassageEvent():
        _showMassage(event.massage);
      case ShowLoadingEvent():
        _showLoading();
      case HideLoadingEvent():
        _hideLoading();
    }
  }

  void _login() async {
    doIntent(ShowLoadingEvent());
    var response = await _loginUseCase(
      emailController.text,
      passwordController.text,
    );
    switch (response) {
      case SuccessResponse<UserEntity>():
        doIntent(HideLoadingEvent());
        doIntent(ShowMassageEvent('Login Successful'));
        Future.delayed(const Duration(seconds: 2), () => streamController.add(NavigateToHomeTempEvent()));
        emit(state.copyWith(
          newLoginState: BaseState<UserEntity>(data: response.data)
        ));
      case ErrorResponse<UserEntity>():
        doIntent(HideLoadingEvent());
        doIntent(ShowMassageEvent(response.error.toString()));
        emit(state);
    }
  }

  void _navigateToRegister() {
    streamController.add(NavigateToRegisterTempEvent());
    emit(state);
  }

  void _showMassage(String massage) {
    streamController.add(ShowMassageTempEvent(massage));
    emit(state);
  }

  void _showLoading() {
    streamController.add(ShowLoadingTempEvent());
  }

  void _hideLoading() {
    streamController.add(HideLoadingTempEvent());
  }
}
