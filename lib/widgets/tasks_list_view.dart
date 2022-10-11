import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todolist/database/task.dart';
import 'package:todolist/database/task_dao.dart';
import 'package:todolist/widgets/todo_item.dart';

class TasksListView extends StatelessWidget {
  const TasksListView({Key? key, required this.taskDao}) : super(key: key);
  final TaskDao taskDao;

  @override
  Widget build(BuildContext context) {

    return Expanded(
        child: StreamBuilder<List<Task>>(

      stream: taskDao.getTasks(),
      builder: (_, snapshot) {
        if (!snapshot.hasData) return Container();
        final tasks = snapshot.requireData;
        return ListView.builder(
            itemCount: tasks.length,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return ToDoItem(task: tasks[index],dao: taskDao);
            });
      },
    ));
  }
}
