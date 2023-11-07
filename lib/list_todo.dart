import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_project/Models/Todo.dart';
import 'package:hive_project/addTodo.dart';
import 'package:hive_project/main.dart';

class todoList extends StatefulWidget {
  const todoList({super.key});

  @override
  State<todoList> createState() => _todoListState();
}

class _todoListState extends State<todoList> {
  late Box<ToDoModel> _myBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _myBox = Hive.box(boxName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do List"),
      ),
      body: ValueListenableBuilder(
        valueListenable: _myBox.listenable(),
        builder: (BuildContext, value, child) {
          if (_myBox.values.isEmpty) {
            return Center(
              child: Text("File Empty"),
            );
          }
          return ListView.builder(
              itemCount: _myBox.values.length,
              itemBuilder: (context, index) {
                ToDoModel? res = _myBox.getAt(index);
                return Dismissible(
                    onDismissed: (direction) {
                      _myBox.deleteAt(index);
                    },
                    key: UniqueKey(),
                    child: ListTile(
                      title: Text("Title: ${res!.Title}"),
                      subtitle: Text("description: ${res.Desc}"),
                    ));
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return addTodo();
          }));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
