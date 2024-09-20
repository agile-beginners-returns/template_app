import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kagb_template/model/todo.dart';
import 'package:kagb_template/provider/todos.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _todoController = TextEditingController();
    final todos = ref.watch(todosProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo App'),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: TextField(
                    controller: _todoController,
                    decoration: const InputDecoration(
                      labelText: 'Enter your Todo',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (text) => submitTodo(text, ref),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          leading: Icon(
                            todos[index].isCompleted
                                ? Icons.check_circle
                                : Icons.circle,
                            color: todos[index].isCompleted
                                ? Colors.green
                                : Colors.grey,
                          ),
                          title: Text(
                            todos[index].todo,
                            style: TextStyle(
                              decoration: todos[index].isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteTodo(ref, todos[index].id),
                          ),
                        ),
                      );
                    },
                    itemCount: todos.length,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  submitTodo(String todo, WidgetRef ref) {
    // TODO: 入力されたTODOをViewModelに通知し、登録する
    final newTodo = Todo(
      todo: todo,
      id: Uuid().v4(),
      isCompleted: false,
    );
    ref.read(todosProvider.notifier).addTodo(newTodo);
  }

  deleteTodo(WidgetRef ref, String id) {
    ref.read(todosProvider.notifier).deleteTodoById(id);
  }
}
