import 'package:dartz/dartz.dart';
import 'package:music_player_flutter/features/home/domain/entities/music_entity.dart';

import '../repositories/home_repository.dart';

class SearchMusicUseCase {
  final HomeRepository repository;

  SearchMusicUseCase(this.repository);

  Future<Either<String, List<MusicEntity>>> execute(String? q) async {
    List<MusicEntity> listMusic = [];
    final result = await repository.getSearchMusic(q);
    return result.fold(
      (failure) {
        return Left(failure.toString());
      },
      (value) {
        if (value.results.isEmpty == true) {
          return const Left('Music Not found');
        } else {
          for (var e in value.results) {
            if (e.previewUrl?.isNotEmpty == true && e.trackName?.isNotEmpty == true) {
              listMusic.add(MusicEntity(
                  id: e.trackId ?? 0,
                  artist: e.artistName ?? '',
                  releaseDate: '${e.releaseDate?.day}-${e.releaseDate?.month}-${e.releaseDate?.year}',
                  cover: e.artworkUrl100 ?? '',
                  url: e.previewUrl ?? '',
                  title: e.trackName ?? '',
                  trackTimeMillis: e.trackTimeMillis ?? 0,
                  artistUrl: e.artistViewUrl ?? '',
                  longDescription: e.longDescription ?? ''));
            }
          }
          return Right(listMusic);
        }
      },
    );
  }
}
