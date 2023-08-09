import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<List<String>> loadCsvData({int start = 0, int end = 1900}) async {
  final csvData = await rootBundle.loadString('assets/target_data.csv');
  final rows = CsvToListConverter().convert(csvData);

  final List<String> words = [];
  for (final row in rows.sublist(start, end)) {
    if (row.isNotEmpty) {
      words.add(row[0].toString());
    }
  }

  return words;
}






