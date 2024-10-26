import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortest_path_calculator/data/models/processing_result_model.dart';

part 'result_list_page_event.dart';

part 'result_list_page_state.dart';

class ResultListPageBloc
    extends Bloc<ResultListPageEvent, ResultListPageState> {
  ResultListPageBloc(List<ProcessingResultModel> processingResults)
      : super(ResultListPageState(processingResults: processingResults));
}
