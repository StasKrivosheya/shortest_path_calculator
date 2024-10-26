import 'dart:async';
import 'dart:convert';

import 'package:shortest_path_calculator/utils/json_mapper.dart';

import '../models/game_config_model.dart';
import '../models/processing_result_model.dart';
import '../models/verification_result_model.dart';
import '../providers/api_provider.dart';

abstract interface class IGameConfigRepository {
  Future<List<GameConfigModel>> getGameConfigs({required String endpoint});

  Future<VerificationResultModel> sendResults(
      List<ProcessingResultModel> processingResults);
}

class GameConfigRepository implements IGameConfigRepository {
  final ApiProvider _dataProvider = ApiProvider();
  late String _lastEndpoint;

  @override
  Future<List<GameConfigModel>> getGameConfigs(
      {required String endpoint}) async {
    try {
      final response = await _dataProvider.getRequest(endpoint: endpoint);
      _lastEndpoint = endpoint;
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

  @override
  Future<VerificationResultModel> sendResults(
      List<ProcessingResultModel> processingResults) async {
    try {
      var encoded = json.encode(processingResults);

      var response = await _dataProvider.postRequest(
        endpoint: _lastEndpoint,
        jsonBody: encoded,
      );

      if (response.statusCode == 200) {
        return VerificationResultModel.fromRawJson(response.body);
      } else {
        throw 'Error sending results';
      }
    } catch (e) {
      rethrow;
    }
  }
}
