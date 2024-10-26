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
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<ProcessPageBloc, ProcessPageState>(
                      buildWhen: (previous, current) =>
                          previous.pageStatus != current.pageStatus,
                      builder: (context, state) {
                        final text = state.pageStatus ==
                                ProcessPageStatus.processing
                            ? 'Data processing is in progress.'
                            : 'All calculations has finished, you can send your results to server.';
                        return Text(
                          text,
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                    // TODO: implement progress indicator
                    // SizedBox(height: 20),
                    // Text('%'),
                    SizedBox(height: 30),
                    BlocBuilder<ProcessPageBloc, ProcessPageState>(
                      buildWhen: (previous, current) =>
                          previous.pageStatus != current.pageStatus,
                      builder: (context, state) {
                        return Visibility(
                            visible: state.pageStatus ==
                                    ProcessPageStatus.processing ||
                                state.pageStatus == ProcessPageStatus.sending,
                            child: CircularProgressIndicator());
                      },
                    )
                  ],
                ),
              ),
            ),
            _SendButton(),
          ],
        ),
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProcessPageBloc, ProcessPageState>(
      buildWhen: (previous, current) =>
          previous.pageStatus != current.pageStatus,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: BorderSide(
                width: 2.5,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            ),
            onPressed: state.pageStatus == ProcessPageStatus.processing ||
                    state.pageStatus == ProcessPageStatus.sending
                ? null
                : () {
                    context.read<ProcessPageBloc>().add(VerificationRequested(
                        processingResults: state.processingResults));
                  },
            child: Text(
              'Send results to server',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
          ),
        );
      },
    );
  }
}
