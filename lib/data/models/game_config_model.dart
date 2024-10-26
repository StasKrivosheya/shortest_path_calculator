import 'coordinates_model.dart';

class GameConfigModel {
  final String id;
  final List<String> field;
  final Coordinates start;
  final Coordinates end;

  GameConfigModel({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  factory GameConfigModel.fromJson(Map<String, dynamic> json) {
    return GameConfigModel(
      id: json['id'] as String,
      field: List<String>.from(json['field']),
      start: Coordinates.fromJson(json['start']),
      end: Coordinates.fromJson(json['end']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'field': field,
      'start': start.toJson(),
      'end': end.toJson(),
    };
  }
}
