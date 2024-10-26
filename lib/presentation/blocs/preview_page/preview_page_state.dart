part of 'preview_page_bloc.dart';

class PreviewPageState extends Equatable {
  final ProcessingResultModel processingResult;

  const PreviewPageState({required this.processingResult});

  @override
  List<Object?> get props => [processingResult];
}
