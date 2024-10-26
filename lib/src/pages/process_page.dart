import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortest_path_calculator/src/blocs/process_page/process_page_bloc.dart';
import 'package:shortest_path_calculator/src/models/game_config_model.dart';
import 'package:shortest_path_calculator/src/repositories/game_config_repository.dart';

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
      body: BlocProvider(
        create: (context) => ProcessPageBloc(
          gameConfigRepository: context.read<GameConfigRepository>(),
        ),
        child: _ProgressPageLayout(gameConfigs: gameConfigs),
      ),
    );
  }
}

class _ProgressPageLayout extends StatelessWidget {
  final List<GameConfigModel> gameConfigs;

  const _ProgressPageLayout({super.key, required this.gameConfigs});

  @override
  Widget build(BuildContext context) {
    context
        .read<ProcessPageBloc>()
        .add(ProcessingRequested(gameConfigs: gameConfigs));
    return SafeArea(
      child: Placeholder(),
    );
  }
}
