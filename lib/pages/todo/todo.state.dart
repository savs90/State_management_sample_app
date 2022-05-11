import '../../models/todo.model.dart';
import '../../repositories/todo.repo.dart';
import '../../basestate/basestate.logic.dart';

class TodoPageStateProvider extends BaseState<TodoPageState> {
  TodoPageStateProvider(TodoPageState init) : super(init);

  void add(TodoModel? todo) {
    if (todo == null) {
      return;
    }
    int newTimestamp = DateTime.now().millisecondsSinceEpoch;
    TodoModel newTodo = TodoModel(todo.id, todo.name, todo.done, newTimestamp, todo.userId);
    int? result = TodoRepoProvider.instance.state.add(newTodo);
    if (result != null) {
      newTodo = TodoModel(result, todo.name, todo.done, newTimestamp, todo.userId);
      state = TodoPageState(todos: [...state.todos, newTodo]);
    }
  }

  void update(TodoModel todo) {
    int newTimestamp = DateTime.now().millisecondsSinceEpoch;
    TodoModel updated = TodoModel(todo.id, todo.name, todo.done, newTimestamp, todo.userId);
    for (int i = 0; i < state.todos.length; i++) {
      if (state.todos[i].id == updated.id) {
        state.todos[i] = updated;
        if (TodoRepoProvider.instance.state.mark(state.todos[i]) == true) {
          state = TodoPageState(todos: state.todos);
        }
      }
    }
  }

  void remove(TodoModel todo) {
    state.todos.removeWhere((e) => e.id == todo.id);
    if (TodoRepoProvider.instance.state.remove(todo.id) == true) {
      state = TodoPageState(todos: state.todos);
    }
  }
}

class TodoPageState {
  final List<TodoModel> todos;

  TodoPageState({required this.todos});
}
