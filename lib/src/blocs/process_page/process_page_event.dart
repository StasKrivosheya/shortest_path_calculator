part of 'process_page_bloc.dart';

sealed class ProcessPageEvent extends Equatable {
  const ProcessPageEvent();
}

class ProcessingRequested extends ProcessPageEvent {
  final List<GameConfigModel> gameConfigs;

  const ProcessingRequested({required this.gameConfigs});

  @override
  List<Object?> get props => [gameConfigs];
}
