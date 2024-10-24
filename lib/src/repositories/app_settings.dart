import 'package:shared_preferences/shared_preferences.dart';

abstract interface class IAppSettings {
  void init();

  Future<void> setApiLink(String apiLink);

  Future<String?> getApiLink();
}

class AppSettings implements IAppSettings {
  static const String _keyApiLink = 'api_link';

  late final SharedPreferencesAsync? _sharedPreferencesAsync;

  @override
  void init() {
    _sharedPreferencesAsync = SharedPreferencesAsync();
  }

  @override
  Future<void> setApiLink(String apiLink) {
    return _sharedPreferencesAsync!.setString(_keyApiLink, apiLink);
  }

  @override
  Future<String?> getApiLink() {
    return _sharedPreferencesAsync!.getString(_keyApiLink);
  }
}
