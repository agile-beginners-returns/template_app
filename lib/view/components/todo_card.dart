import 'package:flutter/material.dart';
import 'package:kagb_template/model/todo.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  final ValueChanged deleteTodo;
  final ValueChanged toggleComplete;

  // 引数コンストラクタ
  const TodoCard({
    super.key,
    required this.todo,
    required this.deleteTodo,
    required this.toggleComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: IconButton(
          icon: Icon(
            todo.isCompleted ? Icons.check_circle : Icons.circle,
            color: todo.isCompleted ? Colors.green : Colors.grey,
          ),
          onPressed: () => toggleComplete(todo),
        ),
        title: Text(
          todo.todoTask,
          style: TextStyle(
            decoration: todo.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => deleteTodo(todo.id),
        ),
      ),
    );
  }
}
