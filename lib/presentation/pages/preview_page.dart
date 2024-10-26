import 'package:flutter/material.dart';
import 'package:shortest_path_calculator/data/models/processing_result_model.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({super.key, required this.processingResult});

  final String title = 'Preview Screen';
  final ProcessingResultModel processingResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_outlined)),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: false,
        title: Text(
          title,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Placeholder(),
    );
  }
}
