// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ToDoFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<String> onChangedTitle;
  final VoidCallback onSaveToDo;

  const ToDoFormWidget({
    Key? key,
    this.title = '',
    this.description = '',
    required this.onChangedDescription,
    required this.onChangedTitle,
    required this.onSaveToDo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTitle(),
            SizedBox(
              height: 0.5,
            ),
            buildDescription(),
            SizedBox(
              height: 30,
            ),
            buildButton(),
          ],
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        onChanged: onChangedTitle,
        validator: (title) {
          if (title!.isEmpty) {
            return 'This title cannot be empty';
          }
          return null;
        },
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Title',
        ),
      );

  Widget buildDescription() => TextFormField(
        maxLines: 3,
        initialValue: description,
        onChanged: onChangedDescription,
        validator: (description) {
          // if (description!.isEmpty) {
          //   return 'This description cannot be empty';
          // }
          return null;
        },
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Description',
        ),
      );

  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black)),
          onPressed: onSaveToDo,
          child: Text('Save'),
        ),
      );
}
