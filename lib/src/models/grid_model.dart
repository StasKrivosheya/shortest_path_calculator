import 'dart:collection';

import 'package:shortest_path_calculator/src/models/cell_model.dart';
import 'package:shortest_path_calculator/src/models/coordinates_model.dart';

class Grid {
  Grid({
    required this.id,
    required List<String> rawField,
    required Coordinates start,
    required Coordinates end,
  })  : _matrix = _initMatrix(rawField, start, end),
        _size = rawField.length,
        _start = start,
        _end = end;

  final String id;
  final List<List<Cell>> _matrix;
  final int _size;
  final Coordinates _start;
  final Coordinates _end;
  List<Cell>? _shortestPath;

  List<Cell>? get shortestPath {
    _shortestPath ??=
        _getShortestPath(_matrix[_start.y][_start.x], _matrix[_end.y][_end.x]);
    return _shortestPath;
  }

  static List<List<Cell>> _initMatrix(
      List<String> rawField, Coordinates start, Coordinates end) {
    final size = rawField.length;

    List<List<Cell>> resultMatrix = List.generate(size, (y) {
      return List.generate(size, (x) {
        var cellType =
            rawField[y][x] == 'X' ? CellType.blocked : CellType.normal;
        return Cell(coordinates: Coordinates(x: x, y: y), type: cellType);
      });
    });

    resultMatrix[start.y][start.x].type = CellType.start;
    resultMatrix[end.y][end.x].type = CellType.end;

    return resultMatrix;
  }

  bool _isValidCoordinates(Coordinates coordinates) {
    return coordinates.x >= 0 &&
        coordinates.x < _size &&
        coordinates.y >= 0 &&
        coordinates.y < _size;
  }

  bool _isValidCell(Cell cell) {
    return cell.isWalkable && _isValidCoordinates(cell.coordinates);
  }

  List<Coordinates> _getPotentialNeighborsCoordinates(
      Coordinates cellCoordinates) {
    const linearDeltas = [-1, 0, 1];
    final neighborDeltas = [
      for (var dx in linearDeltas)
        for (var dy in linearDeltas)
          // excluding current cell from neighbors
          if (dx != 0 || dy != 0) (dx: dx, dy: dy)
    ];

    return [
      for (var nd in neighborDeltas)
        Coordinates(x: cellCoordinates.x + nd.dx, y: cellCoordinates.y + nd.dy)
    ];
  }

  List<Cell> _getNeighborCells(Cell cell) {
    final potentialNeighborCoordinates =
        _getPotentialNeighborsCoordinates(cell.coordinates);

    return [
      for (final pnc in potentialNeighborCoordinates)
        if (_isValidCoordinates(pnc) && _matrix[pnc.y][pnc.x].isWalkable)
          _matrix[pnc.y][pnc.x]
    ];
  }

  List<Cell>? _getShortestPath(Cell start, Cell end) {
    if (!_isValidCell(start) && !_isValidCell(end)) return null;

    Queue<List<Cell>> queue = Queue();
    Set<Cell> visited = {};

    queue.add([start]);
    visited.add(start);

    while (queue.isNotEmpty) {
      var path = queue.removeFirst();
      var current = path.last;

      if (current == end) {
        // for (var cell in path) {
        //   cell.type = CellType.path;
        // }
        final pathRange = (firstStepIndex: 1, lastStepIndex: path.length - 2);
        for (var i = pathRange.firstStepIndex;
            i <= pathRange.lastStepIndex;
            i++) {
          path[i].type = CellType.path;
        }
        return path;
      }

      for (var neighbor in _getNeighborCells(current)) {
        if (!visited.contains(neighbor)) {
          visited.add(neighbor);
          var updatedPath = List<Cell>.from(path)..add(neighbor);
          queue.add(updatedPath);
        }
      }
    }

    return null;
  }
}
