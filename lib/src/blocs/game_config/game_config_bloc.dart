import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shortest_path_calculator/src/models/game_config_model.dart';
import 'package:shortest_path_calculator/src/repositories/app_settings.dart';
import 'package:shortest_path_calculator/src/repositories/game_config_repository.dart';

part 'game_config_event.dart';

part 'game_config_state.dart';

class GameConfigBloc extends Bloc<GameConfigEvent, GameConfigState> {
  final IGameConfigRepository _gameConfigRepository;
  final IAppSettings _appSettings;

  GameConfigBloc({
    required IGameConfigRepository gameConfigRepository,
    required IAppSettings appSettings,
  })  : _gameConfigRepository = gameConfigRepository,
        _appSettings = appSettings,
        super(GameConfigState()) {
    on<ApiLinkInputChanged>(_onApiLinkInputChanged);
    on<GetGameConfigsEvent>(_onGetGameConfigsEvent);
    on<LoadApiLinkFromSettingsEvent>(_onLoadApiLinkFromSettingsEvent);
  }

  FutureOr<void> _onGetGameConfigsEvent(
      GetGameConfigsEvent event, Emitter<GameConfigState> emit) async {
    emit(state.copyWith(pageStatus: HomePageStatus.loading));

    try {
      var potentialEndpoint = state.apiLinkInput;
      final gameConfigs = await _gameConfigRepository.getGameConfigs(
          endpoint: potentialEndpoint);

      if (gameConfigs.isEmpty) {
        emit(state.copyWith(pageStatus: HomePageStatus.empty));
      } else {
        emit(state.copyWith(
            pageStatus: HomePageStatus.success, gameConfigs: gameConfigs));

        await _appSettings.setApiLink(potentialEndpoint);
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

  FutureOr<void> _onLoadApiLinkFromSettingsEvent(
    LoadApiLinkFromSettingsEvent event,
    Emitter<GameConfigState> emit,
  ) async {
    var savedApiLink = await _appSettings.getApiLink();

    if (savedApiLink != null) {
      emit(state.copyWith(apiLinkInput: savedApiLink));
    }
  }
}

// TODO: move to utils
String handleExceptionWithMessage(dynamic error) {
  if (error is SocketException) {
    return "It seems you've entered wrong address or you are not connected to the internet.";
  } else if (error is TimeoutException) {
    return "The request timed out. Ensure you have a stable internet connection";
  } else if (error is ArgumentError) {
    return "Wrong URI format";
  } else {
    return "An error occurred, please try again";
  }
}
