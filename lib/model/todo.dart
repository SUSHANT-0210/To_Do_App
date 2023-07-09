// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/utils.dart';

class ToDoField {
  static const createdTime = 'createdTime';
}

class ToDo {
  DateTime createdTime;
  String title;
  String id;
  String description;
  bool isDone;

  ToDo({
    required this.createdTime,
    required this.title,
    this.id = '',
    this.description = '',
    this.isDone = false,
  });

  static ToDo fromJson(Map<String, dynamic> json) => ToDo(
        // createdTime: Utils.toDateTime(json['createdTime']),
        // createdTime: dateFormat.parse(json['createdTime']),
        createdTime: DateFormat().parse(json['createdTime']),
        title: json['title'],
        description: json['description'],
        id: json['id'],
        isDone: json['isDone'],
      );

  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime),
        'title': title,
        'description': description,
        'id': id,
        'isDone': isDone,
      };
}
