import 'dart:convert';

import 'package:shortest_path_calculator/src/models/coordinates_model.dart';

class ProcessingResultModel {
  final String id;
  final Result result;

  ProcessingResultModel({
    required this.id,
    required this.result,
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
