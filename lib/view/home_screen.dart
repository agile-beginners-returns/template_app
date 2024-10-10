import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kagb_template/extensions/color_code.dart';
import 'package:kagb_template/model/todo.dart';
import 'package:kagb_template/provider/todos.dart';
import 'package:kagb_template/view/components/todo_card.dart';
import 'package:uuid/uuid.dart';
import 'components/openai_test.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _todoController = TextEditingController();
    final todosState = ref.watch(todosProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo App'),
          backgroundColor: HexColor(mainBackGroundColor),
          foregroundColor: HexColor(foregroundColor),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                OpenAITest(),
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
                todosState.when(
                  data: (todos) => Expanded(
                    child: Consumer(
                      builder: (context, ref, child) {
                        return ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return TodoCard(
                              todo: todos[index],
                              deleteTodo: (id) => deleteTodo(ref, id),
                              toggleComplete: (id) => toggleComplete(ref, id),
                            );
                          },
                          itemCount: todos.length,
                        );
                      },
                    ),
                  ),
                  loading: () => const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  error: (error, stack) => Text('Error: $error'),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => getTodos(ref),
          backgroundColor: HexColor(mainBackGroundColor),
          foregroundColor: HexColor(foregroundColor),
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
      todoTask: todo,
      id: const Uuid().v4(),
      isCompleted: false,
    );
    ref.read(todosProvider.notifier).addTodo(newTodo);
    textEditingController.text = "";
  }

  deleteTodo(WidgetRef ref, String id) {
    ref.read(todosProvider.notifier).deleteTodoById(id);
  }

  toggleComplete(
    WidgetRef ref,
    Todo todo,
  ) {
    ref.read(todosProvider.notifier).toggleComplete(todo);
  }

  void getTodos(WidgetRef ref) {
    ref.read(todosProvider.notifier).getTodos();
  }
}
