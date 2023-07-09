// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'package:to_do_app/model/todo.dart';
import 'package:to_do_app/page/edit_todo_page.dart';
import 'package:to_do_app/provider/todos.dart';
import 'package:to_do_app/utils.dart';

class ToDoWidget extends StatelessWidget {
  final ToDo todo;
  const ToDoWidget({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            key: Key(todo.id),
            actions: [
              IconSlideAction(
                icon: Icons.edit,
                color: Colors.green,
                caption: 'Edit',
                onTap: () => editTodo(context, todo),
              ),
            ],
            secondaryActions: [
              IconSlideAction(
                icon: Icons.delete,
                color: Colors.red,
                caption: 'Delete',
                onTap: () => deleteTodo(context, todo),
              ),
            ],
            child: buildTodo(context)),
      );

  Widget buildTodo(BuildContext context) => GestureDetector(
    onTap: () => editTodo(context, todo),
    child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Checkbox(
                activeColor: Theme.of(context).primaryColor,
                checkColor: Colors.white,
                value: todo.isDone,
                onChanged: (_) {
                  final provider =
                      Provider.of<TodosProvider>(context, listen: false);
                  final isDone = provider.toggleTodoStatus(todo);
                  Utils.showSnackBar(context,
                      isDone ? 'Task completed' : 'Task marked incomplete');
                },
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 22),
                  ),
                  if (todo.description.isNotEmpty)
                    Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(todo.description,
                            style: TextStyle(fontSize: 20, height: 1.5)))
                ],
              ))
            ],
          ),
        ),
  );

  void deleteTodo(BuildContext context, ToDo todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(todo);

    Utils.showSnackBar(context, 'Deleted the task');
  }

  void editTodo(BuildContext context, ToDo todo) => Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => EditTodoPage(todo: todo)));
}
