import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/model/todo.dart';
import 'package:to_do_app/provider/todos.dart';
import 'package:to_do_app/widget/todo_form_widget.dart';

class AddToDoDialogWidget extends StatefulWidget {
  const AddToDoDialogWidget({Key? key}) : super(key: key);

  @override
  State<AddToDoDialogWidget> createState() => _AddToDoDialogWidgetState();
}

class _AddToDoDialogWidgetState extends State<AddToDoDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Todo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              ToDoFormWidget(
                onChangedTitle: (title) => setState(() => this.title = title),
                onChangedDescription: (description) =>
                    setState(() => this.description = description),
                onSaveToDo: addTodo,
              )
            ],
          ),
        ),
      );

  void addTodo() {
    final isValid= _formKey.currentState!.validate();

    if(!isValid){
      return;
    }
    else{
      final todo = ToDo(
        id: DateTime.now().toString(),
        title: title,
        description: description,
        createdTime: DateTime.now()
      );

      final provider =Provider.of<TodosProvider>(context,listen: false);
      provider.addTodo(todo);
      Navigator.of(context).pop();




    }

  }
}
