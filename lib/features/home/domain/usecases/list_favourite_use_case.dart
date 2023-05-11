import 'package:dartz/dartz.dart';

import '../entities/music_entity.dart';
import '../repositories/home_repository.dart';

class ListFavouriteUseCase {
  final HomeRepository repository;

  ListFavouriteUseCase(this.repository);

  Future<Either<String, List<MusicEntity>>> execute() async {
    List<MusicEntity> listMusic = [];
    final result = await repository.getListFavourite();
    return result.fold(
      (failure) {
        return const Left('Favourite Music Not Found');
      },
      (result) {
        if (result.isEmpty == true) {
          return const Left('Favourite Music Not Found');
        } else {
          for (var e in result) {
            listMusic.add(MusicEntity(
                id: e.id ?? 0,
                artist: e.artist ?? '',
                releaseDate: e.releaseDate ?? '',
                cover: e.cover ?? '',
                url: e.url ?? '',
                title: e.title ?? '',
                trackTimeMillis: e.trackTimeMillis ?? 0,
                artistUrl: e.artistUrl ?? '',
                longDescription: e.longDescription ?? ''));
          }
          return Right(listMusic);
        }
      },
    );
  }
}
