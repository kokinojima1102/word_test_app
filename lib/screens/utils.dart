import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<List<Map<String, dynamic>>> loadCsvData({int start = 0, int end = 1900}) async {
  final csvData = await rootBundle.loadString('assets/target_data.csv');
  final rows = CsvToListConverter().convert(csvData);

  final List<Map<String, dynamic>> wordsWithIndex = [];
    for (int i = start; i < end; i++) {
        if (rows[i].isNotEmpty) {
            wordsWithIndex.add({'word': rows[i][0].toString(), 'index': i + 1});
        }
    }
    return wordsWithIndex;
}





