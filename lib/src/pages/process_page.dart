import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortest_path_calculator/src/models/game_config_model.dart';

class ProcessPage extends StatelessWidget {
  const ProcessPage({super.key, required this.gameConfigs});

  final List<GameConfigModel> gameConfigs;
  final String title = 'Process Screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: create a custom appbar widget
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
      //body: BlocProvider(create: create),
    );
  }
}

class _ProgressPageLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Placeholder(),
    );
  }
}
