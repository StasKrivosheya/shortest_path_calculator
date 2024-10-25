part of 'home_page_bloc.dart';

sealed class HomePageEvent extends Equatable {
  const HomePageEvent();
}

class ApiLinkInputChanged extends HomePageEvent {
  final String apiLinkInput;

  const ApiLinkInputChanged({required this.apiLinkInput});

  @override
  List<Object?> get props => [apiLinkInput];
}

class GetGameConfigsEvent extends HomePageEvent {
  @override
  List<Object?> get props => [];
}

class LoadApiLinkFromSettingsEvent extends HomePageEvent {
  @override
  List<Object?> get props => [];
}
