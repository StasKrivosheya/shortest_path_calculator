import 'package:flutter/material.dart';
import 'package:shortest_path_calculator/src/models/processing_result_model.dart';

class ResultListPage extends StatelessWidget {
  const ResultListPage({super.key, required this.processingResults});

  final String title = 'Result list screen';
  final List<ProcessingResultModel> processingResults;

  @override
  Widget build(BuildContext context) {
    var a = processingResults;
    return Scaffold(
      appBar: AppBar(),
      body: Placeholder(),
    );
  }
}
