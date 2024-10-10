import 'package:flutter/material.dart';
import 'package:kagb_template/repository/open_ai.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OpenAITest extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageController = TextEditingController();
    final providerNotifier = ref.watch(responseProvider.notifier);
    final providerValue = ref.watch(responseProvider);

    return Column(children: [
      TextField(
        controller: messageController,
        maxLines: 1,
        decoration: const InputDecoration(
          hintText: 'メッセージを入力',
          hintStyle: TextStyle(color: Colors.black54),
        ),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        ElevatedButton(
          child: const Text('AIチャット実行'),
          onPressed: () {
            var msg = messageController.text.trim();
            if (msg.isEmpty) {
              messageController.clear();
              return;
            }
            providerNotifier.clear();
            apiRequest(msg, ref);
          },
        ),
      ]),
      const SizedBox(height: 30),
      Container(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
        ),
        child: Text(
          '$providerValue',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    ]);
  }
}
