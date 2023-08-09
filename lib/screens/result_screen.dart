import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final List<Map<String, dynamic>> incorrectWords; //不正解の単語のリストを保存する変数

  ResultScreen({
    required this.score, 
    required this.totalQuestions,
    required this.incorrectWords,  //コンストラクタにincorrectWordsを追加
  });

  // ランクを計算
  String getRank() {
    double percentage = score / totalQuestions;
    if (percentage == 1.0) return 'S';
    if (percentage >= 0.9) return 'A';
    if (percentage >= 0.8) return 'B';
    if (percentage >= 0.7) return 'C';
    if (percentage >= 0.6) return 'D';
    return 'F';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('結果'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30),  //上部のスペースを確保
            Text(
              'スコア: $score / $totalQuestions',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'ランク: ${getRank()}',
              style: TextStyle(fontSize: 24),
            ),
            //不正解の単語のリストを表示する部分を追加
            SizedBox(height: 20),
            Text('知らなかった単語:', style: TextStyle(fontSize: 20)),
            Expanded(
              child: ListView.builder(
                itemCount: incorrectWords.length,
                itemBuilder: (context, index) {
                    return ListTile(
                        title: Row(
                          children: <Widget>[
                            Container(  //単語番号を表示するContainerを追加
                              width: 55,
                              height: 55,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color(0xFF1F8423),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${incorrectWords[index]['index']}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(width: 16),  //Containerと単語の間にスペースを追加
                            Expanded(
                              child: Text(
                                '${incorrectWords[index]['word']}',
                                style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // トップ画面に戻る
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text('トップ画面に戻る'),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}