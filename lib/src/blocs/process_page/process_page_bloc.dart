import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortest_path_calculator/src/extentions/model_converters.dart';
import 'package:shortest_path_calculator/src/models/game_config_model.dart';
import 'package:shortest_path_calculator/src/models/processing_result_model.dart';
import 'package:shortest_path_calculator/src/repositories/game_config_repository.dart';

part 'process_page_event.dart';

part 'process_page_state.dart';

class ProcessPageBloc extends Bloc<ProcessPageEvent, ProcessPageState> {
  final IGameConfigRepository _gameConfigRepository;

  ProcessPageBloc({required IGameConfigRepository gameConfigRepository})
      : _gameConfigRepository = gameConfigRepository,
        super(ProcessPageState()) {
    on<ProcessingRequested>(_onProcessingRequested);
  }

  FutureOr<void> _onProcessingRequested(
      ProcessingRequested event, Emitter<ProcessPageState> emit) {
    emit(state.copyWith(
        gameConfigs: event.gameConfigs,
        pageStatus: ProcessPageStatus.processing));

    var grids = [for (var gc in event.gameConfigs) gc.toGrid()];

    // calculations are triggered in extension method
    var resultModels = [for (var g in grids) g.toProcessingResult()];

    emit(state.copyWith(
        processingResults: resultModels,
        pageStatus: ProcessPageStatus.readyToSend));
  }
}
