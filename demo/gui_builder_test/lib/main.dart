import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:gui_builder_test/ai_designer.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Center(child: AiDesigner())),
    );
  }
}

@Preview(name: 'Hello Widget')
Widget myHelloWidget() {
  return const Center(
    child: Text(
      'Hello from Flutter AI Lab!',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ),
  );
}
