import '../../basestate/basestate.logic.dart';

class LoginPageStateProvider extends BaseState<LoginPageState> {
  LoginPageStateProvider(LoginPageState init) : super(init);

  void updateUsername(String username) {
    state = LoginPageState(username: username, password: state.password);
  }

  void updatePassword(String password) {
    state = LoginPageState(username: state.username, password: password);
  }
}

class LoginPageState {
  String username;
  String password;

  LoginPageState({
    required this.username,
    required this.password,
  });
}
