import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/model/todo.dart';
import 'package:to_do_app/provider/todos.dart';
import 'package:to_do_app/utils.dart';
import 'package:to_do_app/widget/todo_form_widget.dart';

class EditTodoPage extends StatefulWidget {
  final ToDo todo;
  const EditTodoPage({Key? key, required this.todo}) : super(key: key);

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final _formKey = GlobalKey<FormState>();

  String title = '';
  String description = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    title = widget.todo.title;
    description = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Edit Todo"),
          actions: [
            IconButton(
                onPressed: () {
                  final provider =
                      Provider.of<TodosProvider>(context, listen: false);
                  provider.removeTodo(widget.todo);
                  Navigator.of(context).pop();
                  Utils.showSnackBar(context, 'Deleted the task');
                },
                icon: Icon(Icons.delete))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ToDoFormWidget(
              title: title,
              description: description,
              onChangedDescription: (description) =>
                  setState(() => this.description = description),
              onChangedTitle: (title) => setState(() => this.title = title),
              onSaveToDo: saveTodo,
            ),
          ),
        ),
      );

  void saveTodo() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.updateTodo(widget.todo, title, description);
      Navigator.of(context).pop();
    }
  }
}
