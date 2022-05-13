import '../../models/todo.model.dart';
import '../../basestate/basestate.logic.dart';

class TodoProfilePageStateProvider extends BaseState<TodoProfilePageState> {
  TodoProfilePageStateProvider(TodoProfilePageState init) : super(init, true);

  void updateTask(String newTask) {
    final _cState = state.todo;
    state = TodoProfilePageState(todo: TodoModel(_cState.id, newTask, _cState.done, _cState.timestamp, _cState.userId));
  }

  void updateDone(bool done) {
    final _cState = state.todo;
    state = TodoProfilePageState(todo: TodoModel(_cState.id, _cState.name, done, _cState.timestamp, _cState.userId));
  }
}

class TodoProfilePageState {
  final TodoModel todo;

  TodoProfilePageState({required this.todo});
}
