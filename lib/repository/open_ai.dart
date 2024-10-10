import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class Response extends Notifier<String> {
  @override
  String build() {
    return '';
  }

  void clear() {
    state = '';
  }

  void modify(String message) {
    state = message;
  }
}

final responseProvider = NotifierProvider<Response, String>(() {
  return Response();
});

// OpenAI API実行
Future<void> apiRequest(String message, WidgetRef ref) async {
  String responseMessage;
  final providerNotifier = ref.watch(responseProvider.notifier);
  // 取得したAPIキーを入れる
  await dotenv.load(fileName: '.env');
  var apiKey = dotenv.env['OPEN_AI_API_KEY'];
  const domain = 'api.openai.com';
  const path = 'v1/chat/completions';
  // モデルの指定
  const model = 'gpt-3.5-turbo-0125';

  // APIリクエスト
  http.Response response = await http.post(
    Uri.https(domain, path),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $apiKey',
    },
    body: jsonEncode(<String, dynamic>{
      "model": model,
      "messages": [
        {
          'role': 'system',
          'content': 'あなたはAIではありません。人間として自然な会話をしてください。',
        },
        {
          'role': 'user',
          'content': message,
        },
      ],
    }),
  );

  if (response.statusCode == 200) {
    String responseData = utf8.decode(response.bodyBytes).toString();
    final responseJsonData = jsonDecode(responseData);
    responseMessage = (responseJsonData['choices'] as List).first['message']
        ['content'] as String;
    providerNotifier.modify(responseMessage);
  } else {
    throw Exception('Failed to load sentence');
  }
}
