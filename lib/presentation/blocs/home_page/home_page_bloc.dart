import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shortest_path_calculator/data/models/game_config_model.dart';
import 'package:shortest_path_calculator/data/repositories/app_settings.dart';
import 'package:shortest_path_calculator/data/repositories/game_config_repository.dart';
import 'package:shortest_path_calculator/utils/error_messages.dart';

part 'home_page_event.dart';

part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final IGameConfigRepository _gameConfigRepository;
  final IAppSettings _appSettings;

  HomePageBloc({
    required IGameConfigRepository gameConfigRepository,
    required IAppSettings appSettings,
  })  : _gameConfigRepository = gameConfigRepository,
        _appSettings = appSettings,
        super(HomePageState()) {
    on<ApiLinkInputChanged>(_onApiLinkInputChanged);
    on<GetGameConfigsEvent>(_onGetGameConfigsEvent);
    on<LoadApiLinkFromSettingsEvent>(_onLoadApiLinkFromSettingsEvent);
  }

  FutureOr<void> _onGetGameConfigsEvent(
      GetGameConfigsEvent event, Emitter<HomePageState> emit) async {
    emit(state.copyWith(pageStatus: HomePageStatus.loading));

    try {
      var potentialEndpoint = state.apiLinkInput;
      final gameConfigs = await _gameConfigRepository.getGameConfigs(
          endpoint: potentialEndpoint);

      if (gameConfigs.isNotEmpty) {
        emit(state.copyWith(
            pageStatus: HomePageStatus.success, gameConfigs: gameConfigs));

        await _appSettings.setApiLink(potentialEndpoint);
      } else {
        // TODO: trigger an empty state if necessary
      }
    } catch (e) {
      final message = ErrorMessages.handleExceptionWithMessage(e);
      emit(state.copyWith(
          pageStatus: HomePageStatus.error, errorMessage: message));
    }
  }

  FutureOr<void> _onApiLinkInputChanged(
      ApiLinkInputChanged event, Emitter<HomePageState> emit) {
    emit(state.copyWith(
        apiLinkInput: event.apiLinkInput, pageStatus: HomePageStatus.initial));
  }

  FutureOr<void> _onLoadApiLinkFromSettingsEvent(
    LoadApiLinkFromSettingsEvent event,
    Emitter<HomePageState> emit,
  ) async {
    var savedApiLink = await _appSettings.getApiLink();

    if (savedApiLink != null) {
      emit(state.copyWith(apiLinkInput: savedApiLink));
    }
  }
}
