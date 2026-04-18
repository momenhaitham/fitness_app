sealed class LoginEvents {}

class Login extends LoginEvents {}

class NavigateToRegisterEvent extends LoginEvents {}

class ShowMassageEvent extends LoginEvents {
  final String massage;
  ShowMassageEvent(this.massage);
}

class ShowLoadingEvent extends LoginEvents {}
class HideLoadingEvent extends LoginEvents {}
