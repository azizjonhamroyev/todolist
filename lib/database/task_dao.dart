import 'package:floor/floor.dart';
import 'package:todolist/database/task.dart';

@dao
abstract class TaskDao {
  @insert
  Future<void> insertTask(Task task);

  @delete
  Future<void> deleteTask(Task task);

  @Query('SELECT * FROM Task')
  Stream<List<Task>> getTasks();
}
