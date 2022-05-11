import './model.dart';

class UserModel extends Model {
  final int id;
  final String username;
  final String password;

  const UserModel(this.id, this.username, this.password);
}
