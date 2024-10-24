part of 'game_config_bloc.dart';

sealed class GameConfigState extends Equatable {
  const GameConfigState();

  @override
  List<Object> get props => [];
}

final class GameConfigInitial extends GameConfigState {}

final class GameConfigLoadingState extends GameConfigState {}

final class GameConfigEmptyState extends GameConfigState {}

final class GameConfigLoadingFailedState extends GameConfigState {
  final String errorMessage;

  const GameConfigLoadingFailedState({required this.errorMessage});
}

final class GameConfigLoadedState extends GameConfigState {
  final List<Object> gameConfigs;

  const GameConfigLoadedState({required this.gameConfigs});

  @override
  List<Object> get props => [gameConfigs];
}
