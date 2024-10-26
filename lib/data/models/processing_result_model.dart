import 'dart:convert';

import 'coordinates_model.dart';
import 'grid_model.dart';

class ProcessingResultModel {
  final String id;
  final Result result;
  final GameGrid finalGameGrid;

  ProcessingResultModel({
    required this.id,
    required this.result,
    required this.finalGameGrid
  });

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "result": result.toJson(),
      };
}

class Result {
  final List<Coordinates> steps;
  final String path;

  Result({
    required this.steps,
    required this.path,
  });

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
        "path": path,
      };
}
