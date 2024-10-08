import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:kagb_template/model/todo.dart';

part 'database.g.dart';

class TodoItems extends Table {
  TextColumn get id => text()();
  TextColumn get todoTask => text()();
  BoolColumn get isCompleted => boolean()();
}

@DriftDatabase(tables: [TodoItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // データベースのスキーマを変更する時に、schemaVersionを上げる
  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: "todo_database");
  }

  Future<List<TodoItem>> getTodos() async {
    final dbTodos = await select(todoItems).get();
    return dbTodos;
  }

  Future<void> addTodo(Todo todo) async {
    await into(todoItems).insert(TodoItemsCompanion.insert(
      id: todo.id,
      todoTask: todo.todoTask,
      isCompleted: todo.isCompleted,
    ));
  }

  Future<void> deleteTodo(String id) async {
    await (delete(todoItems)..where((dbTodo) => dbTodo.id.equals(id))).go();
  }

  Future<void> toggleComplete(Todo todo) async {
    final currentTodoCompleted = todo.isCompleted;
    await (update(todoItems)..where((dbTodo) => dbTodo.id.equals(todo.id)))
        .write(TodoItemsCompanion(isCompleted: Value(!currentTodoCompleted)));
  }
}
