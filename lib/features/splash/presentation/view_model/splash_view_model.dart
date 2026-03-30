
import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/config/base_state/custom_cubit.dart';
import 'package:fitness_app/config/local_storage_processes/domain/use_case/get_first_time_launched_use_case.dart';
import 'package:fitness_app/config/local_storage_processes/domain/use_case/get_remember_me_use_case.dart';
import 'package:fitness_app/features/splash/presentation/view_model/splash_event.dart';
import 'package:fitness_app/features/splash/presentation/view_model/splash_intent.dart';
import 'package:fitness_app/features/splash/presentation/view_model/splash_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class SplashViewModel extends CustomCubit<SplashEvent, SplashState> {
  final GetRememberMeUseCase _getRememberMeUseCase;
  final GetFirstTimeLaunchedUseCase _getFirstTimeLaunchedUseCase;
  SplashViewModel(this._getRememberMeUseCase,this._getFirstTimeLaunchedUseCase)
    : super(SplashState(splashState: BaseState()));

  void doIntent(SplashIntent intent) {
    switch (intent) {
      case NavigateAction():
        {
          _initSplash();
        }
    }
  }

  Future<void> _initSplash() async {
    final rememberMeResult = _getRememberMeUseCase.invoke();
    final firstTimeLaunchedResult = await _getFirstTimeLaunchedUseCase.invokeGetFirstTimeLaunched();
    if(firstTimeLaunchedResult == null || firstTimeLaunchedResult == true){
      _navToOnBoarding();
      return;
    }
    if (rememberMeResult != null && rememberMeResult == true) {
      _navToHome();
    } else {
      _navToLogin();
    }
  }

  void _navToLogin() {
    Future.delayed(
      const Duration(seconds: 4),
      () => streamController.add(NavigateToLoginEvent()),
    );
  }

  void _navToHome() {
    Future.delayed(
      const Duration(seconds: 4),
      () => streamController.add(NavigateToMainFlowEvent()),
    );
  }

  void _navToOnBoarding() {
    Future.delayed(
      const Duration(seconds: 4),
      () => streamController.add(NavigateToOnboardingEvent()),
    );
  }
}
