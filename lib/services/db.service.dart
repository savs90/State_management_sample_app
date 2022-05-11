import '../basestate/basestate.logic.dart';
import '../models/model.dart';
import '../models/user.model.dart';
import '../models/todo.model.dart';

class DatabaseService extends BaseState<Database> {
  static DatabaseService instance = DatabaseService(Database());

  DatabaseService(Database init) : super(init);
}

class Database {
  int idCounter = 10;
  // Some hardcoded data
  final List<UserModel> _users = [
    const UserModel(1, "admin", "admin"),
    const UserModel(2, "user", "user"),
  ];
  final List<TodoModel> _todos = [
    const TodoModel(1, "Buy myself a present", false, 1652118322000, 1),
    const TodoModel(2, "Buy food", false, 1652118122000, 1),
    const TodoModel(3, "Relax", false, 1652117022000, 1),
    const TodoModel(4, "User stuff", false, 1652118022000, 2),
    const TodoModel(5, "Don't forget it!", false, 1652118112000, 2),
  ];

  List<dynamic> query<T extends Model>() {
    if (T == UserModel) return _users;
    if (T == TodoModel) return _todos;
    return [];
  }

  int? add(Model model) {
    if (model is UserModel) _users.add(UserModel(idCounter, model.username, model.password));
    if (model is TodoModel) _todos.add(TodoModel(idCounter, model.name, model.done, model.timestamp, model.userId));
    return idCounter++;
  }

  bool update(Model model) {
    if (model is UserModel) {
      for (int i = 0; i < _users.length; i++) {
        if (_users[i].id == model.id) {
          _users[i] = model;
        }
      }
    }
    if (model is TodoModel) {
      for (int i = 0; i < _todos.length; i++) {
        if (_todos[i].id == model.id) {
          _todos[i] = model;
        }
      }
    }
    return true;
  }

  bool delete<Model>(int id) {
    if (Model == UserModel) _users.removeWhere((e) => e.id == id);
    if (Model == TodoModel) _todos.removeWhere((e) => e.id == id);
    return true;
  }
}
