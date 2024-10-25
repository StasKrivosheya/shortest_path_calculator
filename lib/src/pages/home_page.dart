import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortest_path_calculator/src/blocs/home_page/home_page_bloc.dart';
import 'package:shortest_path_calculator/src/pages/process_page.dart';
import 'package:shortest_path_calculator/src/repositories/app_settings.dart';
import 'package:shortest_path_calculator/src/repositories/game_config_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final String title = 'Home Screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        create: (context) => HomePageBloc(
          gameConfigRepository: context.read<GameConfigRepository>(),
          appSettings: context.read<AppSettings>(),
        ),
        child: _HomePageLayout(),
      ),
    );
  }
}

class _HomePageLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<HomePageBloc>().add(LoadApiLinkFromSettingsEvent());
    return BlocListener<HomePageBloc, HomePageState>(
      listenWhen: (previous, current) =>
          previous.pageStatus != current.pageStatus,
      listener: (context, state) {
        if (state.pageStatus == HomePageStatus.success) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              final gameConfigs = state.gameConfigs;
              return ProcessPage(gameConfigs: gameConfigs);
            }),
          );
        }
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Set valid API base URL in order to continue',
                style: TextStyle(fontSize: 16),
              ),
              Row(
                children: [
                  Icon(Icons.compare_arrows),
                  SizedBox(width: 20),
                  Expanded(child: _ApiLinkInput()),
                ],
              ),
              _ErrorIndicator(),
              _LoadingIndicator(),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: _StartButton(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      buildWhen: (previous, current) =>
          previous.pageStatus != current.pageStatus,
      builder: (context, state) {
        return Visibility(
          visible: state.pageStatus == HomePageStatus.error,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                state.errorMessage,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
        buildWhen: (previous, current) =>
            previous.pageStatus != current.pageStatus,
        builder: (context, state) {
          return Expanded(
            child: Visibility(
              visible: state.pageStatus == HomePageStatus.loading,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        });
  }
}

class _StartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      buildWhen: (previous, current) =>
          previous.pageStatus != current.pageStatus,
      builder: (context, state) {
        return ElevatedButton(
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
          onPressed: state.pageStatus == HomePageStatus.loading
              ? null
              : () {
                  context.read<HomePageBloc>().add(GetGameConfigsEvent());
                },
          child: Text(
            'Start counting process',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer),
          ),
        );
      },
    );
  }
}

class _ApiLinkInput extends StatelessWidget {
  final TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      buildWhen: (previous, current) =>
          previous.apiLinkInput != current.apiLinkInput,
      builder: (context, state) {
        _inputController.value = TextEditingValue(
            text: state.apiLinkInput,
            selection: TextSelection.fromPosition(
                TextPosition(offset: state.apiLinkInput.length)));

        return TextField(
          onChanged: (input) => context
              .read<HomePageBloc>()
              .add(ApiLinkInputChanged(apiLinkInput: input)),
          controller: _inputController,
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'API URL',
          ),
        );
      },
    );
  }
}
