import 'package:flutter/material.dart';
import 'quiz_screen.dart';
import '../range_selection_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'geenus α',
            style: TextStyle(fontWeight: FontWeight.bold),
            ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RangeSelectionScreen()),
            );
          },
          child: Text('テストを開始'),
        ),
      ),
    );
  }
}
