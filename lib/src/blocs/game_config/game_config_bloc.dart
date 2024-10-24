import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shortest_path_calculator/src/models/game_config_model.dart';
import 'package:shortest_path_calculator/src/repositories/game_config_repository.dart';

part 'game_config_event.dart';

part 'game_config_state.dart';

class GameConfigBloc extends Bloc<GameConfigEvent, GameConfigState> {
  final GameConfigRepository gameConfigRepository;

  GameConfigBloc({required this.gameConfigRepository})
      : super(GameConfigState()) {
    on<ApiLinkInputChanged>(_onApiLinkInputChanged);
    on<GetGameConfigsEvent>(_onGetGameConfigsEvent);
  }

  FutureOr<void> _onGetGameConfigsEvent(
      GetGameConfigsEvent event, Emitter<GameConfigState> emit) async {
    emit(state.copyWith(pageStatus: HomePageStatus.loading));

    try {
      var potentialEndpoint = state.apiLinkInput;
      final gameConfigs = await gameConfigRepository.getGameConfigs(
          endpoint: potentialEndpoint);

      if (gameConfigs.isEmpty) {
        emit(state.copyWith(pageStatus: HomePageStatus.empty));
      } else {
        emit(state.copyWith(
            pageStatus: HomePageStatus.success, gameConfigs: gameConfigs));

        // TODO: add to appsettings
      }
    } catch (e) {
      final message = handleExceptionWithMessage(e);
      emit(state.copyWith(
          pageStatus: HomePageStatus.error, errorMessage: message));
    }
  }

  FutureOr<void> _onApiLinkInputChanged(
      ApiLinkInputChanged event, Emitter<GameConfigState> emit) {
    // TODO: validate input if necessary
    emit(state.copyWith(
        apiLinkInput: event.apiLinkInput, pageStatus: HomePageStatus.initial));
  }
}

// TODO: move to utils
String handleExceptionWithMessage(dynamic error) {
  if (error is SocketException) {
    return "It seems you've entered wrong address or you are not connected to the internet.";
  } else if (error is TimeoutException) {
    return "The request timed out. Ensure you have a stable internet connection";
  } else if(error is ArgumentError) {
    return "Wrong URI format";
  } else {
    return "An error occurred, please try again";
  }
}
