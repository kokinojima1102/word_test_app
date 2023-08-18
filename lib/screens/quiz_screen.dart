import 'dart:async';
import 'package:flutter/material.dart';
import 'package:word_test_app/screens/utils.dart';
import 'package:word_test_app/screens/result_screen.dart';

class QuizScreen extends StatefulWidget {
  final DateTime startTime;
  final int startWordIndex;
  final int endWordIndex;
  final int numQuestions;

  QuizScreen({
              required this.startWordIndex, 
              required this.endWordIndex,
              required this.numQuestions,
              required this.startTime
              }); 

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Map<String, dynamic>> words = [];
  int currentIndex = 0;
  int score = 0;
  Timer? timer;
  DateTime? startTime;
  DateTime? endTime;
  double progressValue = 0.0;
  List<Map<String, dynamic>> incorrectWords = [];
  // 不正解の単語のリストを保存する変数
  // Futureを返すinitDataメソッドを作成
  Future<void> initData() async {
    var loadedWords = await loadCsvData(start: widget.startWordIndex, end: widget.endWordIndex);
    setState(() {
      words = loadedWords;
    });
    if (widget.numQuestions > 0 && widget.numQuestions < words.length) {
      words.shuffle();
      words = words.take(widget.numQuestions).toList();
    }
    resetTimer();
  }

  // initStateメソッドでinitDataメソッドを呼び出す
  @override
  void initState() {
    super.initState();
    startTime = widget.startTime;
    initData();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void resetTimer() {
    timer?.cancel();

    timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        progressValue += 0.005;
        if (progressValue >= 1.0) {
          nextQuestion(false);
        }
      });
    });
  }

  void nextQuestion(bool isKnown) {
    if (!isKnown) {
        incorrectWords.add({
            'word': words[currentIndex]['word'],
            'index': words[currentIndex]['index'],
            'translation': words[currentIndex]['translation']
        });
    }
    if (isKnown) score++;
    if (currentIndex < words.length - 1) {
      currentIndex++;
      progressValue = 0.0;
      resetTimer();
    } else {
        endTime = DateTime.now();
        Duration elapsedTime = endTime!.difference(startTime!);
        Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            score: score,
            totalQuestions: words.length,
            incorrectWords: incorrectWords,  //incorrectWordsも渡す
            allWords: words, //出題した全ての単語も渡す
            elapsedTime: elapsedTime, 
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('単語テスト'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: LinearProgressIndicator(
            value: progressValue,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ),
      ),
      body: words.length == 0
          // データ読み込み中はローディング画面を表示
          ? Center(child: CircularProgressIndicator())
          // データ読み込み完了後はクイズ画面を表示
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    words[currentIndex]['word'],
                    style: TextStyle(fontSize: 32),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => nextQuestion(true),
                        child: Text('知っている'),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () => nextQuestion(false),
                        child: Text('知らない'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}




