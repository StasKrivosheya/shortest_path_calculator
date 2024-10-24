import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/repositories/game_config_repository.dart';
import 'src/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => GameConfigRepository(),
      child: MaterialApp(
          title: 'Flutter Test Task',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(34, 150, 243, 100),
            ),
            useMaterial3: true,
          ),
          home: const MyHomePage()),
    );
  }
}
