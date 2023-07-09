import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/model/todo.dart';
import 'package:to_do_app/provider/todos.dart';
import 'package:to_do_app/widget/todo_widget.dart';

class ToDoListWidget extends StatelessWidget {
  const ToDoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todos;

    return todos.isEmpty
        ? Center(
          child: Text(
              'No todos',
              style: TextStyle(fontSize: 20),
            ),
        )
        : ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            separatorBuilder: (context, index) => Container(
              height: 8,
            ),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return ToDoWidget(
                todo: todo,
              );
            },
          );
  }
}
