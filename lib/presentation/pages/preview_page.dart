import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortest_path_calculator/data/models/cell_model.dart';
import 'package:shortest_path_calculator/data/models/processing_result_model.dart';
import 'package:shortest_path_calculator/presentation/blocs/preview_page/preview_page_bloc.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({super.key, required this.processingResult});

  final String title = 'Preview Screen';
  final ProcessingResultModel processingResult;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PreviewPageBloc(processingResult),
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
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _GameGridDisplayWidget(),
              SizedBox(height: 15),
              Text(
                processingResult.result.path.toString(),
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GameGridDisplayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameGrid =
        context.read<PreviewPageBloc>().state.processingResult.finalGameGrid;

    final flatGrid = gameGrid.asFlatList;

    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gameGrid.size),
        itemCount: flatGrid.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final cell = flatGrid[index];
          return _CellWidget(cell: cell);
        });
  }
}

class _CellWidget extends StatelessWidget {
  final Cell cell;

  const _CellWidget({super.key, required this.cell});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.5),
      child: Container(
        decoration: BoxDecoration(
          color: switch (cell.type) {
            CellType.start => Color.fromRGBO(100, 255, 218, 1),
            CellType.end => Color.fromRGBO(0, 150, 136, 1),
            CellType.path => Color.fromRGBO(76, 175, 80, 1),
            CellType.blocked => Colors.black54,
            _ => Colors.white,
          }, // Assume Cell has a color property
          border: Border.all(
            color: Colors.black,
            width: 0.5,
          ),
        ),
        child: Center(
          child: Text(
            cell.coordinates.toString(),
            // Assume Cell has a label or identifier
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
