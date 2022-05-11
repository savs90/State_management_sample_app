import './model.dart';

class TodoModel extends Model {
  final int id;
  final String name;
  final bool done;
  final int timestamp;
  final int userId;

  const TodoModel(this.id, this.name, this.done, this.timestamp, this.userId);
}
