import 'package:kagb_template/model/todo.dart';
import 'package:kagb_template/repository/todo_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todos.g.dart';

@riverpod
class Todos extends _$Todos {
  final TodoRepository _repository = TodoRepository();
  @override
  Future<List<Todo>> build() async => await _repository.getTodos();

  // 端末のデータベースに保存されたTodoを呼び出し、riverpodで管理するListを初期化
  Future<List<Todo>> getTodos() async {
    return await _repository.getTodos();
  }

  // db、stateにtodoを追加するメソッドを追加する
  void addTodo(Todo newTodo) async {
    await _repository.addTodo(newTodo);
    final recentlyTodos = await _repository.getTodos();
    // stateの更新
    state = AsyncData(recentlyTodos);
  }

  // 引数に渡されたidと一致するtodoを削除する
  void deleteTodoById(String id) async {
    await _repository.deleteTodoById(id);
    final recentlyTodos = await _repository.getTodos();

    state = AsyncData(recentlyTodos);
  }

  // 引数に渡されたTodoに一致するTodoのcompleteを反転させる
  void toggleComplete(Todo todo) async {
    await _repository.toggleComplete(todo);
    final recentlyTodos = await _repository.getTodos();

    state = AsyncData(recentlyTodos);
  }
}
