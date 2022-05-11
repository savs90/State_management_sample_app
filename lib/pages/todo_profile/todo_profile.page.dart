import 'package:flutter/material.dart';
import '../../services/auth.service.dart';
import './todo_profile.state.dart';
import '../../models/todo.model.dart';
import '../../basestate/basestate.widget.dart';

class TodoProfilePage extends StatelessWidget {
  late final TodoProfilePageStateProvider instance;
  final TodoModel? todo;
  final TextEditingController taskController = TextEditingController();

  TodoProfilePage({this.todo, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    instance = TodoProfilePageStateProvider(
      TodoProfilePageState(todo: todo ?? TodoModel(-1, "", false, 0, AuthService.instance.state.getId!)),
    );
    taskController.text = instance.state.todo.name;

    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO Profile"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Open shopping cart',
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(
                child: BaseStateWidget<TodoProfilePageStateProvider, TodoProfilePageState>(
                  state: instance,
                  builder: (state) {
                    return ListView(
                      itemExtent: 80,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      children: [
                        TextField(
                          controller: taskController,
                          readOnly: false,
                          obscureText: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Task',
                          ),
                          onChanged: instance.updateTask,
                        ),
                        CheckboxListTile(
                          title: const Text("Finished"),
                          value: instance.state.todo.done,
                          onChanged: (check) => instance.updateDone(check ?? false),
                        ),
                        if (instance.state.todo.timestamp > 0)
                          ListTile(
                            title: const Text("Last updated: "),
                            trailing: Text(DateTime.fromMillisecondsSinceEpoch(instance.state.todo.timestamp).toIso8601String()),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.cancel),
                        Text("Cancel"),
                      ],
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(
                  child: OutlinedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.save),
                        Text("Save"),
                      ],
                    ),
                    onPressed: () {
                      Navigator.pop(context, instance.state.todo);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
