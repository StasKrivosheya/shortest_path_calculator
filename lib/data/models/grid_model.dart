import 'cell_model.dart';

class GameGrid {
  final List<List<Cell>> _fieldMatrix;

  GameGrid({required List<List<Cell>> fieldMatrix}) : _fieldMatrix = fieldMatrix;

  Cell operator [](({int x, int y}) coordinates) =>
      _fieldMatrix[coordinates.y][coordinates.x];

  int get size => _fieldMatrix.length;

  List<Cell> get asFlatList {
    List<Cell> result = [];
    for (var row in _fieldMatrix) {
      result.addAll(row);
    }
    return result;
  }
}
