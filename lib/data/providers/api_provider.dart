import 'package:http/http.dart' as http;

class ApiProvider {
  Future<http.Response> getRequest({required String endpoint}) async {
    try {
      final response = await http.get(Uri.parse(endpoint));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> postRequest(
      {required String endpoint, required String jsonBody}) async {
    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonBody,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
