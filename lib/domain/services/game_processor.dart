import 'dart:collection';

import 'package:shortest_path_calculator/data/models/cell_model.dart';
import 'package:shortest_path_calculator/data/models/coordinates_model.dart';
import 'package:shortest_path_calculator/data/models/game_config_model.dart';
import 'package:shortest_path_calculator/data/models/grid_model.dart';
import 'package:shortest_path_calculator/data/models/processing_result_model.dart';

abstract interface class IGameProcessorService {
  List<ProcessingResultModel> findShortestPaths(
      List<GameConfigModel> gameConfigs);
}

class GameProcessorService implements IGameProcessorService {
  @override
  List<ProcessingResultModel> findShortestPaths(
      List<GameConfigModel> gameConfigs) {
    return [for (var gc in gameConfigs) _findShortestPath(gc)];
  }

  ProcessingResultModel _findShortestPath(GameConfigModel gameConfig) {
    final cellMatrix =
        _initMatrix(gameConfig.field, gameConfig.start, gameConfig.end);
    final startingCell = cellMatrix[gameConfig.start.y][gameConfig.start.x];
    final endingCell = cellMatrix[gameConfig.end.y][gameConfig.end.x];

    var shortestPath = _getShortestPath(cellMatrix, startingCell, endingCell)!;

    // update path sell type
    for (var updatedCell in shortestPath) {
      cellMatrix[updatedCell.coordinates.y][updatedCell.coordinates.x].type =
          updatedCell.type;
    }

    return ProcessingResultModel(
      id: gameConfig.id,
      result: Result(
        steps: shortestPath
            .map((cell) => cell.coordinates)
            .toList(growable: false),
        path: shortestPath.join('->'),
      ),
      finalGameGrid: GameGrid(fieldMatrix: cellMatrix),
    );
  }

  List<List<Cell>> _initMatrix(
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

  bool _isValidCoordinates(Coordinates coordinates, int rangeLimit) {
    return coordinates.x >= 0 &&
        coordinates.x < rangeLimit &&
        coordinates.y >= 0 &&
        coordinates.y < rangeLimit;
  }

  bool _isValidCell(Cell cell, int matrixSize) {
    return cell.isWalkable && _isValidCoordinates(cell.coordinates, matrixSize);
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

  List<Cell> _getNeighborCells(Cell cell, List<List<Cell>> matrix) {
    final potentialNeighborCoordinates =
        _getPotentialNeighborsCoordinates(cell.coordinates);

    return [
      for (final pnc in potentialNeighborCoordinates)
        if (_isValidCoordinates(pnc, matrix.length) &&
            matrix[pnc.y][pnc.x].isWalkable)
          matrix[pnc.y][pnc.x]
    ];
  }

  List<Cell>? _getShortestPath(List<List<Cell>> matrix, Cell start, Cell end) {
    if (!_isValidCell(start, matrix.length) &&
        !_isValidCell(end, matrix.length)) return null;

    Queue<List<Cell>> queue = Queue();
    Set<Cell> visited = {};

    queue.add([start]);
    visited.add(start);

    while (queue.isNotEmpty) {
      var path = queue.removeFirst();
      var current = path.last;

      if (current == end) {
        final pathRange = (firstStepIndex: 1, lastStepIndex: path.length - 2);
        for (var i = pathRange.firstStepIndex;
            i <= pathRange.lastStepIndex;
            i++) {
          path[i].type = CellType.path;
        }
        return path;
      }

      for (var neighbor in _getNeighborCells(current, matrix)) {
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
