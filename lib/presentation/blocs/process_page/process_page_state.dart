part of 'process_page_bloc.dart';

enum ProcessPageStatus {
  initial,
  processing,
  readyToSend,
  sending,
  error,
  success,
}

class ProcessPageState extends Equatable {
  const ProcessPageState({
    this.gameConfigs = const [],
    this.processingResults = const [],
    this.pageStatus = ProcessPageStatus.initial,
  });

  final List<GameConfigModel> gameConfigs;
  final List<ProcessingResultModel> processingResults;
  final ProcessPageStatus pageStatus;

  ProcessPageState copyWith({
    List<GameConfigModel>? gameConfigs,
    List<ProcessingResultModel>? processingResults,
    ProcessPageStatus? pageStatus,
  }) {
    return ProcessPageState(
      gameConfigs: gameConfigs ?? this.gameConfigs,
      processingResults: processingResults ?? this.processingResults,
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }

  @override
  List<Object?> get props => [gameConfigs, processingResults, pageStatus];
}
