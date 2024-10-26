import 'package:shortest_path_calculator/data/models/game_config_model.dart';

class JsonMapper {
  static List<GameConfigModel> mapGameConfigs({dynamic decodedBody}) {
    return (decodedBody['data'] as List)
        .map((config) => GameConfigModel.fromJson(config))
        .toList();
  }
}
