import 'package:kagb_template/main.dart';
import 'package:kagb_template/model/todo.dart';

class TodoRepository {
  // データベースに保存されたTodoを呼び出す
  Future<List<Todo>> getTodos() async {
    final dbTodos = await database.getTodos();
    // dbのレコードクラス(TodoItem Class)を、アプリ内で使うTodoClassに変換
    final todos = dbTodos
        .map((dbTodo) => Todo(
              todoTask: dbTodo.todoTask,
              id: dbTodo.id,
              isCompleted: dbTodo.isCompleted,
            ))
        .toList();
    return todos;
  }

  // stateの配列に新しくtodoインスタンスを追加するメソッドを追加したい
  Future<void> addTodo(Todo newTodo) async {
    await database.addTodo(newTodo);
  }

  // stateから、引数に渡されたdeleteTodoとidが一致するものを削除したい
  Future<void> deleteTodoById(String id) async {
    await database.deleteTodo(id);
  }

  // 引数に渡されたTodo.idと一致するTodoのcompleteを反転させたい
  Future<void> toggleComplete(Todo todo) async {
    await database.toggleComplete(todo);
  }
}
