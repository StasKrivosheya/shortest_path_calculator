import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shortest_path_calculator/src/repositories/game_config_repository.dart';

part 'game_config_event.dart';

part 'game_config_state.dart';

class GameConfigBloc extends Bloc<GameConfigEvent, GameConfigState> {
  final GameConfigRepository gameConfigRepository;

  GameConfigBloc({required this.gameConfigRepository})
      : super(GameConfigInitial()) {
    on<GetGameConfigsEvent>(_onGetGameConfigsEvent);
  }

  FutureOr<void> _onGetGameConfigsEvent(
      GetGameConfigsEvent event, Emitter<GameConfigState> emit) async {
    emit(GameConfigLoadingState());

    try {
      final gameConfigs = await gameConfigRepository.getGameConfigs(
          endpoint: 'https://flutter.webspark.dev/flutter/api');

      if (gameConfigs.isEmpty) {
        emit(GameConfigEmptyState());
      } else {
        emit(GameConfigLoadedState(gameConfigs: gameConfigs));
      }
    } catch (e) {
      final message = handleExceptionWithMessage(e);
      emit(GameConfigLoadingFailedState(errorMessage: message));
    }
  }
}

String handleExceptionWithMessage(dynamic error) {
  if (error is SocketException) {
    return "It seems you are not connected to the internet.";
  } else if (error is TimeoutException) {
    return "The request timed out. Ensure you have a stable internet connection";
  } else {
    return "An error occurred, please try again";
  }
}
