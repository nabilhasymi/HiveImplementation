import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_project/Models/Todo.dart';
import 'package:hive_project/list_todo.dart';

String boxName = "To Do Box";

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<ToDoModel>(ToDoModelAdapter());
  await Hive.openBox<ToDoModel>(boxName);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: todoList(),
    );
  }
}
