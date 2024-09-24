import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kagb_template/model/todo.dart';
import 'package:kagb_template/provider/todos.dart';
import 'package:kagb_template/view/components/todo_card.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _todoController = TextEditingController();

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
                    onSubmitted: (text) =>
                        submitTodo(text, ref, _todoController),
                  ),
                ),
                Expanded(
                  child: Consumer(
                    builder: (context, ref, child) {
                      final todos = ref.watch(todosProvider);
                      return ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return TodoCard(
                            todo: todos[index],
                            deleteTodo: (id) => deleteTodo(ref, id),
                          );
                        },
                        itemCount: todos.length,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => print("押された"),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  submitTodo(
    String todo,
    WidgetRef ref,
    TextEditingController textEditingController,
  ) {
    final newTodo = Todo(
      todo: todo,
      id: const Uuid().v4(),
      isCompleted: false,
    );
    ref.read(todosProvider.notifier).addTodo(newTodo);
    textEditingController.text = "";
  }

  deleteTodo(WidgetRef ref, String id) {
    ref.read(todosProvider.notifier).deleteTodoById(id);
  }
}
