sealed class LoginTempEvents {}

class NavigateToRegisterTempEvent extends LoginTempEvents {}

class NavigateToHomeTempEvent extends LoginTempEvents {}

class ShowMassageTempEvent extends LoginTempEvents {
  final String massage;
  ShowMassageTempEvent(this.massage);
}

class ShowLoadingTempEvent extends LoginTempEvents {}
class HideLoadingTempEvent extends LoginTempEvents {}
