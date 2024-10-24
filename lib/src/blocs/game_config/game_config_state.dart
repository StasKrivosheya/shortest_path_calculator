part of 'game_config_bloc.dart';

enum HomePageStatus { initial, loading, calculating, error, success, empty }

class GameConfigState extends Equatable {
  const GameConfigState({
    this.pageStatus = HomePageStatus.initial,
    this.apiLinkInput = '',
    this.errorMessage = '',
    this.gameConfigs = const [],
  });

  final HomePageStatus pageStatus;
  final String apiLinkInput;
  final String errorMessage;
  final List<GameConfigModel> gameConfigs;

  GameConfigState copyWith({
    HomePageStatus? pageStatus,
    String? apiLinkInput,
    String? errorMessage,
    List<GameConfigModel>? gameConfigs,
  }) {
    return GameConfigState(
      pageStatus: pageStatus ?? this.pageStatus,
      apiLinkInput: apiLinkInput ?? this.apiLinkInput,
      errorMessage: errorMessage ?? this.errorMessage,
      gameConfigs: gameConfigs ?? this.gameConfigs,
    );
  }

  @override
  List<Object> get props =>
      [pageStatus, apiLinkInput, errorMessage, gameConfigs];
}

// sealed class GameConfigState extends Equatable {
//   const GameConfigState();
//
//   @override
//   List<Object> get props => [];
// }
//
// final class GameConfigInitial extends GameConfigState {}
//
// final class GameConfigLoadingState extends GameConfigState {}
//
// final class GameConfigEmptyState extends GameConfigState {}
//
// final class GameConfigLoadingFailedState extends GameConfigState {
//   final String errorMessage;
//
//   const GameConfigLoadingFailedState({required this.errorMessage});
// }
//
// final class GameConfigLoadedState extends GameConfigState {
//   final List<Object> gameConfigs;
//
//   const GameConfigLoadedState({required this.gameConfigs});
//
//   @override
//   List<Object> get props => [gameConfigs];
// }
