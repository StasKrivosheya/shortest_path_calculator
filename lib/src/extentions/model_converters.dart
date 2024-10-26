import 'package:shortest_path_calculator/src/models/game_config_model.dart';
import 'package:shortest_path_calculator/src/models/grid_model.dart';
import 'package:shortest_path_calculator/src/models/processing_result_model.dart';

extension ToGrid on GameConfigModel {
  Grid toGrid() {
    return Grid(id: id, rawField: field, start: start, end: end);
  }
}

extension ToProcessingResult on Grid {
  ProcessingResultModel toProcessingResult() {
    return ProcessingResultModel(
        id: id,
        result: Result(
            steps: shortestPath!
                .map((cell) => cell.coordinates)
                .toList(growable: false),
            path: shortestPath!.join('->')));
  }
}
