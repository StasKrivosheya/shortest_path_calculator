import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shortest_path_calculator/data/models/processing_result_model.dart';

part 'preview_page_event.dart';

part 'preview_page_state.dart';

class PreviewPageBloc extends Bloc<PreviewPageEvent, PreviewPageState> {
  PreviewPageBloc(ProcessingResultModel processingResult)
      : super(PreviewPageState(processingResult: processingResult));
}
