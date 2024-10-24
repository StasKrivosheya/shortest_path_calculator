import 'dart:convert';

import 'package:shortest_path_calculator/src/models/game_config_model.dart';
import 'package:shortest_path_calculator/src/services/data_provider.dart';
import 'package:shortest_path_calculator/src/utils/json_mapper.dart';

class GameConfigRepository {
  final DataProvider _dataProvider = DataProvider();

  Future<List<GameConfigModel>> getGameConfigs(
      {required String endpoint}) async {
    try {
      final response = await _dataProvider.getRequest(endpoint: endpoint);
      if (response.statusCode == 200) {
        Map<String, dynamic> decodedBody = json.decode(response.body);
        return JsonMapper.mapGameConfigs(decodedBody: decodedBody);
      } else {
        throw 'Error loading game configs';
      }
    } catch (e) {
      rethrow;
    }
  }
}
