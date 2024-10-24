part of 'game_config_bloc.dart';

sealed class GameConfigEvent extends Equatable {
  const GameConfigEvent();
}

class ApiLinkInputChanged extends GameConfigEvent {
  final String apiLinkInput;

  const ApiLinkInputChanged({required this.apiLinkInput});

  @override
  List<Object?> get props => [apiLinkInput];
}

class GetGameConfigsEvent extends GameConfigEvent {
  @override
  List<Object?> get props => [];
}
