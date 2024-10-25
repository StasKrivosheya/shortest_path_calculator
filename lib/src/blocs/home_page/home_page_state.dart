part of 'home_page_bloc.dart';

enum HomePageStatus { initial, loading, error, success }

class HomePageState extends Equatable {
  const HomePageState({
    this.pageStatus = HomePageStatus.initial,
    this.apiLinkInput = '',
    this.errorMessage = '',
    this.gameConfigs = const [],
  });

  final HomePageStatus pageStatus;
  final String apiLinkInput;
  final String errorMessage;
  final List<GameConfigModel> gameConfigs;

  HomePageState copyWith({
    HomePageStatus? pageStatus,
    String? apiLinkInput,
    String? errorMessage,
    List<GameConfigModel>? gameConfigs,
  }) {
    return HomePageState(
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
