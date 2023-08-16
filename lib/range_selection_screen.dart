import 'package:flutter/material.dart';
import 'package:word_test_app/screens/quiz_screen.dart';

class RangeSelectionScreen extends StatefulWidget {
  @override
  _RangeSelectionScreenState createState() => _RangeSelectionScreenState();
}

class _RangeSelectionScreenState extends State<RangeSelectionScreen> {
  // 開始値と終了値を管理するためのTextEditingControllerを作成
  final _startController = TextEditingController();
  final _endController = TextEditingController();
  final _numQuestionsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('範囲選択'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 開始値を入力するTextFieldウィジェットを作成
            Center(
              child: Container(
                width: 150,
                child: TextField(
                  controller: _startController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Start',
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),  // TextField間のスペースを作るためのSizedBox
            // 終了値を入力するTextFieldウィジェットを作成
            Center(
              child: Container(
                width: 150,
                child: TextField(
                  controller: _endController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'End',
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),  //インデント調整

            //問題数を選択するTextField
            Center(
              child: Container(
                width: 150,
                child: TextField(
                  controller: _numQuestionsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'number',
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),  // インデント調整

            // クイズを開始するボタンを作成
            // ボタンが押されたときには、入力された範囲の値を取得し、
            // それらが有効な範囲であることを確認した上でQuizScreenに遷移
            ElevatedButton(
              child: Text('テストを開始'),
              onPressed: () {
                // 入力されたテキストを数値に変換
                int? startRange = int.tryParse(_startController.text);
                int? endRange = int.tryParse(_endController.text);
                // 入力が数値でない場合、または開始範囲が終了範囲以上の場合は、
                // エラーメッセージを表示
                if (startRange == null || startRange < 1 || startRange > 1900 || endRange == null || endRange < 1 || endRange > 1900) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('1から1900の範囲で数値を入力してください')),
                  );
                  return;
                }

                if (startRange == null || startRange == 0 || endRange == null || endRange == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('正しい数値を入力してください')),
                  );
                  return;
                }

                if (startRange >= endRange) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('正しい範囲を入力してください')),
                  );
                  return;
                }

                int? numQuestions = int.tryParse(_numQuestionsController.text);
                if (numQuestions != null && (endRange - startRange + 1) < numQuestions) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('選択範囲が出題数に満たないです')),
                    );
                    return;
                }
                
                // 範囲が有効であればQuizScreenに遷移
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(
                      numQuestions: int.tryParse(_numQuestionsController.text) ?? 0,
                      startWordIndex: startRange -1,
                      endWordIndex: endRange ,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
