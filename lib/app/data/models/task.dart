import 'dart:convert';
import 'package:equatable/equatable.dart';

class Task extends Equatable {
  const Task({
    required this.title,
    required this.icon,
    required this.color,
    this.todos,
  });

  final String title;
  final int icon;
  final String color;
  final List<dynamic>? todos;

  Task copyWith({
    String? title,
    int? icon,
    String? color,
    List<dynamic>? todos,
  }) {
    return Task(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      todos: todos ?? this.todos,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'icon': icon,
      'color': color,
      'todos': todos,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] as String,
      icon: map['icon'] as int,
      color: map['color'] as String,
      todos: map['todos'] != null
          ? List<dynamic>.from((map['todos'] as List<dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [title, icon, color];
}
