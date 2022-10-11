import 'package:floor/floor.dart';

@entity
class Task {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  String title;

  int priority;

  Task(this.id, this.title, this.priority);
}
