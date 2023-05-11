import 'package:http/http.dart' as http;

Future<T> handleResponse<T>({required Future<http.Response> Function() request, required T Function(http.Response) onResponse}) async {
  try {
    final result = await request();
    return onResponse(result);
  } on Exception catch (e) {
    throw Exception(e);
  }
}
