import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:todolist/database/task.dart';
import 'package:todolist/database/task_dao.dart';

part 'database.g.dart';

@Database(version: 4, entities: [Task])
abstract class AppDatabase extends FloorDatabase {
  TaskDao get taskDao;
}
