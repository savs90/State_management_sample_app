import './repo.dart';
import '../models/user.model.dart';
import '../services/db.service.dart';
import '../basestate/basestate.logic.dart';

class UserRepoProvider extends BaseState<UserRepo> {
  static UserRepoProvider instance = UserRepoProvider(UserRepo(DatabaseService.instance.state));

  UserRepoProvider(UserRepo init) : super(init);
}

class UserRepo extends Repo<UserModel> {
  final Database _db;

  UserRepo(this._db);

  UserModel? getByUsername(String username) {
    final users = _db.query<UserModel>();
    try {
      return users.firstWhere((e) => (e as UserModel).username == username);
    } catch (err) {
      return null;
    }
  }

  @override
  UserModel? getById(int id) {
    final users = _db.query<UserModel>();
    try {
      return users.firstWhere((e) => (e as UserModel).id == id);
    } catch (err) {
      return null;
    }
  }

  @override
  List<UserModel> getAll() {
    final users = _db.query<UserModel>();
    return users as List<UserModel>;
  }

  @override
  int? add(UserModel model) {
    return _db.add(model);
  }

  @override
  bool remove(int id) {
    return _db.delete<UserModel>(id);
  }
}
