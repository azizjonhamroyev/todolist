import 'package:flutter/material.dart';
import 'package:todolist/database/task_dao.dart';
import 'package:todolist/utils/colors.dart';

import '../database/task.dart';

class ToDoItem extends StatelessWidget {
  const ToDoItem({Key? key, required this.task, required this.dao})
      : super(key: key);

  final TaskDao dao;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: () => showDialog(
            context: context,
            builder: (BuildContext buildContext) => AlertDialog(
                  title: const Text("Ushbu topshiriqni o'chrishni xohlaysizmi"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          dao.deleteTask(task);
                          Navigator.pop(context);
                        },
                        child: const Text("Ha")),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Yo'q"))
                  ],
                )),
        child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 60,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: MyColors.gray),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 20),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Color(task.priority),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(9))),
                    ),
                    const SizedBox(width: 20),
                    Text(task.title, style: const TextStyle(fontSize: 18)),
                  ],
                ),
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                      color: MyColors.lightGreen,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  child: const Icon(Icons.check, color: Colors.white, size: 30),
                )
              ],
            )));
  }
}
