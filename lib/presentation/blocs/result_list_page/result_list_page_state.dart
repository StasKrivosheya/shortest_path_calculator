part of 'result_list_page_bloc.dart';

class ResultListPageState extends Equatable {
  final List<ProcessingResultModel> processingResults;

  const ResultListPageState({required this.processingResults});

  @override
  List<Object?> get props => [processingResults];
}
