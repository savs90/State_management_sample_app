import 'package:flutter/material.dart';
import './todo.state.dart';
import '../login/login.page.dart';
import '../todo_profile/todo_profile.page.dart';
import '../../models/todo.model.dart';
import '../../repositories/todo.repo.dart';
import '../../services/auth.service.dart';
import '../../basestate/basestate.widget.dart';

class TodoPage extends StatelessWidget {
  final TodoPageStateProvider instance = TodoPageStateProvider(
    TodoPageState(todos: TodoRepoProvider.instance.state.getByUser(AuthService.instance.state.getId!)),
  );

  TodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO list"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Open shopping cart',
            onPressed: () {
              AuthService.instance.logOut();
              if (AuthService.instance.state.isLoggedIn == false) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: BaseStateWidget<TodoPageStateProvider, TodoPageState>(
                state: instance,
                builder: (state) {
                  return ListView.builder(
                    itemCount: instance.state.todos.length,
                    itemExtent: 60,
                    itemBuilder: (context, idx) {
                      final todo = state.todos[idx];
                      return InkWell(
                        key: Key(todo.id.toString()),
                        child: Row(
                          children: [
                            Checkbox(
                              value: todo.done,
                              onChanged: (newState) => instance.update(TodoModel(todo.id, todo.name, newState ?? false, todo.timestamp, todo.userId)),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(todo.name),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              color: Colors.red[600],
                              onPressed: () => instance.remove(todo),
                            ),
                          ],
                        ),
                        onTap: () async {
                          final _todo = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TodoProfilePage(todo: todo),
                            ),
                          );
                          if (_todo != null) {
                            instance.update(_todo);
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ),
            OutlinedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.add),
                  Text("New todo"),
                ],
              ),
              onPressed: () async {
                final _todo = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TodoProfilePage(),
                  ),
                );
                if (_todo != null) {
                  instance.add(_todo);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
