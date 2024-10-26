import 'dart:convert';

class Coordinates {
  final int x;
  final int y;

  Coordinates({
    required this.x,
    required this.y,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      x: json['x'] as int,
      y: json['y'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'x': x,
        'y': y,
      };

  String toRawJson() => json.encode(toJson());

  @override
  String toString() => '($x, $y)';
}
