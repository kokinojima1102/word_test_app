import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final int score;
  final int totalQuestions;
  final List<Map<String, dynamic>> incorrectWords; //不正解の単語のリストを保存
  final List<Map<String, dynamic>> allWords;  //出題範囲全てのリスト
  final Duration elapsedTime;   //合計時間

  ResultScreen({
    required this.score,
    required this.totalQuestions,
    required this.incorrectWords,
    required this.allWords,
    required this.elapsedTime,
  });

  @override
  _ResultScreenState createState() => _ResultScreenState(
        score: score,
        totalQuestions: totalQuestions,
        incorrectWords: incorrectWords,
        allWords: allWords,
  );
}

class _ResultScreenState extends State<ResultScreen> {
  final int score;
  final int totalQuestions;
  final List<Map<String, dynamic>> incorrectWords; //不正解の単語のリストを保存
  final List<Map<String, dynamic>> allWords;  //出題範囲全てのリスト
  bool _showIncorrectWordsOnly = false;
  Duration get elapsedTime => widget.elapsedTime;


  _ResultScreenState({
    required this.score, 
    required this.totalQuestions,
    required this.incorrectWords,  //コンストラクタにincorrectWordsを追加
    required this.allWords,
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
            Container(
              width: 180,  
              alignment: Alignment.centerLeft,
              child: Text(
                'スコア： $score / $totalQuestions',
                style: TextStyle(fontSize: 24),
              ),
            ),
            Container(
              width: 180,  
              alignment: Alignment.centerLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline, 
                textBaseline: TextBaseline.alphabetic, 
                children: <Widget>[
                  Text(
                    'ランク：',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(width: 20),  
                  Text(
                    '${getRank()}',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
            Container(
              width: 180,
              alignment: Alignment.centerLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  Text(
                    'タイム：',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(width: 20),
                  Text(
                    '${elapsedTime.inSeconds % 60}秒',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
            //不正解の単語のリストを表示する部分を追加
            SizedBox(height: 20),
            Text('テスト結果', style: TextStyle(fontSize: 20)),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 30), 
                      Padding(
                      padding: EdgeInsets.only(right: 4),  
                      child: Text('不正解のみ表示'),
                      ),
                      Checkbox(
                        value: _showIncorrectWordsOnly,
                        onChanged: (bool? newValue) {
                          setState(() {
                            _showIncorrectWordsOnly = newValue!;
                          });
                        },
                      ),
                    ],
                  ),

                  Expanded(
                    child: ListView.builder(
                      itemCount: _showIncorrectWordsOnly ? incorrectWords.length : allWords.length,
                      itemBuilder: (context, index) {
                        final word = _showIncorrectWordsOnly ? incorrectWords[index] : allWords[index];// 不正解の単語か確認
                        final bool isIncorrect = incorrectWords.any((element) => element['word'] == word['word']);  
                          return ListTile(
                              contentPadding: EdgeInsets.only(left: 30.0),
                              title: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(  //単語番号を表示するContainer
                                    width: 55,
                                    height: 55,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF1F8423),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      '${word['index']}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(width: 16),  //Containerと単語の間にスペース
                                  Container(
                                    width: 140,  
                                    child: Text(
                                      '${word['word']}',
                                      style: TextStyle(fontSize: 20,
                                      color: isIncorrect ? Colors.red : Colors.black
                                      ),
                                      overflow: TextOverflow.ellipsis,  //長すぎると省略
                                    ),
                                  ),
                                  
                                  Text(
                                    ' - ${word['translation']}',
                                    style: TextStyle(fontSize: 20,
                                    color: isIncorrect ? Colors.red : Colors.black),
                                  ),
                                ],
                              ),
                            );
                        },
                    ),
                  ),
                ],
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