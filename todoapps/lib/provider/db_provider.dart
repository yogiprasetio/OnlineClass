import 'package:flutter/material.dart';
import 'package:todoapps/utils/helper_databases.dart';

import '../data/model/to_do.dart';

class DbProvider extends ChangeNotifier {
  List<Todo> _arrToDo = [];
  List<Todo> get todos => _arrToDo;
  late HelperDatabases _dbHelper;

  DbProvider() {
    _dbHelper = HelperDatabases();
    _getAllTodos();
  }

  void _getAllTodos() async {
    _arrToDo = await _dbHelper.getTodos();
    notifyListeners();
  }

  Future<void> addTodo(Todo todo) async {
    await _dbHelper.insertTodo(todo);
    _getAllTodos();
  }

  Future<Todo> getTodoById(int id) async {
    return await _dbHelper.getTodoBy(id);
  }

  Future<Todo> getOldestTodo() async {
    return await _dbHelper.getOldestTodo();
  }

  Future<void> upDateTodo(Todo todo) async {
    await _dbHelper.updateTodoBy(todo);
    _getAllTodos();
  }

  Future<void> deleteTodo(int id) async {
    await _dbHelper.deleteTodoBy(id);
    _getAllTodos();
  }
}
