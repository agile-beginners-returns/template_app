import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _todoController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: _todoController,
                decoration: const InputDecoration(
                  labelText: 'Enter your Todo',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (text) => submitTodo(text),
              ),
            ],
          ),
        ),
      ),
    );
  }

  submitTodo(String todo) {
    // TODO: 入力されたTODOをViewModelに通知し、登録する
    print("入力されたTODO $todo");
  }
}
