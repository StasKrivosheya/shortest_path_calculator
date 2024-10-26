import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repositories/app_settings.dart';
import 'data/repositories/game_config_repository.dart';
import 'presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => GameConfigRepository(),
        ),
        RepositoryProvider(
          create: (context) => AppSettings()..init(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Test Task',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(34, 150, 243, 100),
          ),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
