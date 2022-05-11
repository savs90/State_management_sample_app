import '../basestate/basestate.logic.dart';
import '../models/user.model.dart';
import '../repositories/user.repo.dart';

class AuthService extends BaseState<AuthState> {
  static AuthService instance = AuthService(AuthState(null, false));

  AuthService(AuthState init) : super(init);

  void logIn(String username, String password) {
    UserModel? _res = UserRepoProvider.instance.state.getByUsername(username);
    if (_res == null) {
      error("The user does not exists");
    }
    if (password == _res?.password) {
      state = AuthState(_res, true);
    } else {
      error("Invalid username or password");
    }
  }

  void logOut() {
    state = AuthState(null, false);
  }
}

class AuthState {
  final bool _loggedIn;
  final UserModel? _data;

  AuthState(this._data, this._loggedIn);

  bool get isLoggedIn => _loggedIn;
  int? get getId => _data?.id;
  String? get user => _data?.username;
}
