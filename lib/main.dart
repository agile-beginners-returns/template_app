import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:kagb_template/db/database.dart";
import "package:kagb_template/view/home_screen.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";

late AppDatabase database;
Future<void> main() async{
  await dotenv.load(fileName: '.env');
  database = AppDatabase();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
