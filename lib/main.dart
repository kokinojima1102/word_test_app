import 'package:flutter/material.dart';
import 'screens/quiz_screen.dart';
import 'screens/result_screen.dart';
import 'screens/home_screen.dart';
import 'range_selection_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // このウィジェットはアプリケーションのルートです。
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'geenus α',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Color(0xFF1F8423),
        ),
      ),
      home: HomeScreen(), // ホーム画面を最初の画面として設定
    );
  }
}
