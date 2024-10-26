import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortest_path_calculator/src/extensions/model_converters.dart';
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
    on<VerificationRequested>(_onVerificationRequested);
  }

  FutureOr<void> _onProcessingRequested(
      ProcessingRequested event, Emitter<ProcessPageState> emit) async {
    emit(state.copyWith(
        gameConfigs: event.gameConfigs,
        pageStatus: ProcessPageStatus.processing));

    var resultModels = await _computeResults(event.gameConfigs);

    emit(state.copyWith(
        processingResults: resultModels,
        pageStatus: ProcessPageStatus.readyToSend));
  }

  Future<List<ProcessingResultModel>> _computeResults(
      List<GameConfigModel> gameConfigs) async {
    var grids = [for (var gc in gameConfigs) gc.toGrid()];

    // calculations are triggered in extension method
    var resultModels = [for (var g in grids) g.toProcessingResult()];

    return Future.value(resultModels);
  }

  FutureOr<void> _onVerificationRequested(VerificationRequested event, Emitter<ProcessPageState> emit) async {
    var results = await _gameConfigRepository.sendResults(event.processingResults);

    var resultsCorrect = true;
    for (var gamePath in results.data) {
      if (!gamePath.correct) {
        resultsCorrect = false;
      }
      break;
    }

    if (resultsCorrect) {
      emit(state.copyWith(pageStatus: ProcessPageStatus.success));
    } else {
      emit(state.copyWith(pageStatus: ProcessPageStatus.error));
    }
  }
}
