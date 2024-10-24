part of 'game_config_bloc.dart';

sealed class GameConfigEvent extends Equatable {
  const GameConfigEvent();

  // todo: implement props
  @override
  List<Object?> get props => [];
}

class GetGameConfigsEvent extends GameConfigEvent {}
