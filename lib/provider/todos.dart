import 'package:kagb_template/model/todo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todos.g.dart';

@riverpod
class Todos extends _$Todos {
  @override
  List<Todo> build() {
    return [];
  }

  // stateの配列に新しくtodoインスタンスを追加するメソッドを追加したい
  void addTodo(Todo newTodo) {
    state = [...state, newTodo];
  }

  // stateから、引数に渡されたdeleteTodoとidが一致するものを削除したい
  void deleteTodoById(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}
