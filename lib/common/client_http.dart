import 'package:http/http.dart' as http;

class ClientHttp {
  final http.Client _httpClient;
  final String? url;

  ClientHttp(this._httpClient, this.url);

  requestApi(
    method,
    path,
  ) async {
    if (method.toLowerCase() == 'get') {
      return await _get(url, path);
    }
  }

  Future<http.Response> _get(baseUrl, String path) async {
    final header = {
      "content-type": "application/text",
    };
    return await _httpClient
        .get(
          Uri.parse("$baseUrl/$path"),
          headers: header,
        )
        .onError((error, stackTrace) => throw Exception(error));
  }
}
