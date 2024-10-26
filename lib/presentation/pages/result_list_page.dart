import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortest_path_calculator/data/models/processing_result_model.dart';
import 'package:shortest_path_calculator/presentation/blocs/result_list_page/result_list_page_bloc.dart';
import 'package:shortest_path_calculator/presentation/pages/preview_page.dart';

class ResultListPage extends StatelessWidget {
  const ResultListPage({super.key, required this.processingResults});

  final String title = 'Result list screen';
  final List<ProcessingResultModel> processingResults;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResultListPageBloc(processingResults),
      child: Scaffold(
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
        body: _ResultListPageLayout(),
      ),
    );
  }
}

class _ResultListPageLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultListPageBloc, ResultListPageState>(
      builder: (context, state) {
        var processingResults = state.processingResults;

        return ListView.separated(
          padding: const EdgeInsets.all(10),
          itemCount: processingResults.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PreviewPage(
                            processingResult: processingResults[index])));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 5,
                ),
                child: Text(
                  processingResults[index].result.path,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Colors.grey,
              height: 0,
            );
          },
        );
      },
    );
  }
}
