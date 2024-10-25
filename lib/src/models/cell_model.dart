import 'coordinates_model.dart';

enum CellType { normal, blocked, start, end, path }

class Cell {
  final Coordinates coordinates;
  CellType type;

  Cell({required this.coordinates, required this.type});

  bool get isWalkable => type != CellType.blocked;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Cell &&
          runtimeType == other.runtimeType &&
          coordinates.x == other.coordinates.x &&
          coordinates.y == other.coordinates.y;

  @override
  int get hashCode => coordinates.x.hashCode ^ coordinates.y.hashCode;

  @override
  String toString() => coordinates.toString();
}
