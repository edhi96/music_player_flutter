import 'dart:async';
import 'dart:convert';

import '../../../../common/client_http.dart';
import '../../../../common/handle_response.dart';
import '../model/music_model.dart';
import '../model/music_response.dart';

abstract class HomeRemoteDataSource {
  FutureOr<MusicResponse<MusicModel>> search(String keyword);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ClientHttp client;

  HomeRemoteDataSourceImpl({required this.client});

  @override
  FutureOr<MusicResponse<MusicModel>> search(String keyword) {
    return handleResponse(request: () async {
      var query = keyword.isEmpty ? '' : keyword.replaceAll(' ', '+').toLowerCase();
      return await client.requestApi('GET', '/search?term=$query&term=all');
    }, onResponse: (result) {
      return MusicResponse<MusicModel>.fromJson(jsonDecode(result.body.toString()));
    });
  }
}
