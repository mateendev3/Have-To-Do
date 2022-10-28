import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/controller.dart';

class CompletedTodoList extends StatelessWidget {
  CompletedTodoList({Key? key}) : super(key: key);

  final HomeController _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          ..._homeController.completedTodos.map(
            (completedTodo) {
              log(completedTodo);
              return CheckboxListTile(
                value: true,
                onChanged: (value) {
                  _homeController.doneTodo(completedTodo['title']);
                },
                checkColor: Colors.grey,
                title: Text(completedTodo['title']),
                controlAffinity: ListTileControlAffinity.leading,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedTodoListItems() {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        ..._homeController.completedTodos.map(
          (completedTodo) => CheckboxListTile(
            value: true,
            onChanged: (value) {
              _homeController.doneTodo(completedTodo['title']);
            },
            checkColor: Colors.grey,
            title: Text(completedTodo['title']),
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ),
      ],
    );
  }
}
