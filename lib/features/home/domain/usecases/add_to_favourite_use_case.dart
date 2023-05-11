import 'package:music_player_flutter/features/home/data/model/music_table.dart';
import 'package:music_player_flutter/features/home/domain/entities/music_entity.dart';
import 'package:music_player_flutter/features/home/domain/repositories/detail_music_repository.dart';

class AddToFavouriteUseCase {
  final DetailMusicRepository repository;

  AddToFavouriteUseCase(this.repository);

  Future<String> execute(MusicEntity entity) async {
    final result = await repository.addToFavourite(
      MusicTable(
          id: entity.id,
          title: entity.title,
          artist: entity.artist,
          url: entity.url,
          cover: entity.cover,
          trackTimeMillis: entity.trackTimeMillis,
          artistUrl: entity.artistUrl,
          releaseDate: entity.releaseDate,
          longDescription: entity.longDescription),
    );
    return result.fold(
      (failure) {
        return failure.message;
      },
      (result) {
        return result;
      },
    );
  }
}
