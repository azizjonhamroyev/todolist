import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todolist/database/database.dart';
import 'package:todolist/database/task.dart';
import 'package:todolist/utils/colors.dart';
import 'package:todolist/utils/create_material_color.dart';
import 'package:todolist/widgets/tasks_list_view.dart';

import 'database/task_dao.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase.databaseBuilder('tasks.db').build();
  final dao = database.taskDao;
  runApp(MyApp(dao));
}

class MyApp extends StatelessWidget with CreateMaterialColor {
  final TaskDao dao;

  const MyApp(this.dao, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: createMaterialColor(MyColors.mainColor),
      ),
      home: MyHomePage(title: 'Qaydnoma', dao: dao),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.dao});

  final TaskDao dao;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedColor = 0;
  String tvText = '';

  @override
  StatefulWidget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    MaterialButton green = MaterialButton(
      elevation: 0,
      onPressed: () {
        setState(() {
          selectedColor = MyColors.greenCode;
        });
      },
      color: MyColors.green,
      shape: const CircleBorder(),
      child: selectedColor == MyColors.greenCode
          ? const Icon(
              Icons.check,
              color: Colors.white,
            )
          : null,
    );
    MaterialButton red = MaterialButton(
      elevation: 0,
      onPressed: () {
        setState(() {
          selectedColor = MyColors.redCode;
        });
      },
      color: MyColors.red,
      shape: const CircleBorder(),
      child: selectedColor == MyColors.redCode
          ? const Icon(
              Icons.check,
              color: Colors.white,
            )
          : null,
    );
    MaterialButton mainColor = MaterialButton(
      elevation: 0,
      onPressed: () {
        setState(() {
          selectedColor = MyColors.mainColorCode;
        });
      },
      color: MyColors.mainColor,
      shape: const CircleBorder(),
      child: selectedColor == MyColors.mainColorCode
          ? const Icon(
        Icons.check,
        color: Colors.white,
      )
          : null,
    );

    MaterialButton blue = MaterialButton(
      elevation: 0,
      onPressed: () {
        setState(() {
          selectedColor = MyColors.blueCode;
        });
      },
      color: MyColors.blue,
      shape: const CircleBorder(),
      child: selectedColor == MyColors.blueCode
          ? const Icon(
        Icons.check,
        color: Colors.white,
      )
          : null,
    );
    MaterialButton orange = MaterialButton(
      elevation: 0,
      onPressed: () {
        setState(() {
          selectedColor = MyColors.orangeCode;
        });
      },
      color: MyColors.orange,
      shape: const CircleBorder(),
      child: selectedColor == MyColors.orangeCode
          ? const Icon(
        Icons.check,
        color: Colors.white,
      )
          : null,
    );

    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: MyColors.mainColor,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light),
          title: Text(widget.title),
          centerTitle: true,
          elevation: 1,
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TasksListView(taskDao: widget.dao),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(child: green),
                          Flexible(child: red),
                          Flexible(child: mainColor),
                          Flexible(child: blue),
                          Flexible(child: orange)
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        bottomLeft: Radius.circular(15)),
                                    border: Border.all(color: MyColors.blue)),
                                child: TextField(
                                  controller: textEditingController,
                                  style: const TextStyle(fontSize: 20),
                                  onChanged: (text) {
                                    tvText = text;
                                  },
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                )),
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              widthFactor: 1,
                              child: Flexible(
                                  child: MaterialButton(
                                minWidth: 50,
                                height: 50,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10))),
                                onPressed: () {
                                  if (checkIsNotEmpty(tvText) &&
                                      selectedColor != 0) {
                                    widget.dao.insertTask(
                                        Task(null, tvText, selectedColor));
                                    selectedColor = 0;
                                    textEditingController.clear();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Rangni tanlang yoki maydonni to'ldiring")));
                                  }
                                },
                                color: MyColors.black,
                                child:
                                    const Icon(Icons.add, color: Colors.white),
                              )))
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ));
  }

  bool checkIsNotEmpty(String s) {
    for (int i = 0; i < s.length; i++) {
      if (s[i] != ' ' && s[i] != '\n') {
        return true;
      }
    }
    return false;
  }
}
