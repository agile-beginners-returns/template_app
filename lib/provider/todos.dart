import 'package:kagb_template/model/todo.dart';
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

  // 引数に渡されたTodo.idと一致するTodoのcompleteを反転させたい
  void toggleComplete(String id) {
    state = state.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(
          isCompleted: !todo.isCompleted,
        );
      } else {
        return todo;
      }
    }).toList();
  }
}
