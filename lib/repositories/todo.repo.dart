import './repo.dart';
import '../models/todo.model.dart';
import '../services/db.service.dart';
import '../basestate/basestate.logic.dart';

class TodoRepoProvider extends BaseState<TodoRepo> {
  static TodoRepoProvider instance = TodoRepoProvider(TodoRepo(DatabaseService.instance.state));

  TodoRepoProvider(TodoRepo init) : super(init);
}

class TodoRepo extends Repo<TodoModel> {
  final Database _db;

  TodoRepo(this._db);

  bool mark(TodoModel model) {
    return _db.update(model);
  }

  List<TodoModel> getByUser(int userId) {
    List<TodoModel> todos = [];
    final allTodos = _db.query<TodoModel>();
    for (int i = 0; i < allTodos.length; i++) {
      if ((allTodos[i] as TodoModel).userId == userId) {
        todos.add(allTodos[i]);
      }
    }
    return todos;
  }

  @override
  TodoModel? getById(int id) {
    final todos = _db.query<TodoModel>();
    try {
      return todos.firstWhere((e) => e.id == id);
    } catch (err) {
      return null;
    }
  }

  @override
  List<TodoModel> getAll() {
    final todos = _db.query<TodoModel>();
    return todos as List<TodoModel>;
  }

  @override
  int? add(TodoModel model) {
    return _db.add(model);
  }

  @override
  bool remove(int id) {
    return _db.delete<TodoModel>(id);
  }
}
