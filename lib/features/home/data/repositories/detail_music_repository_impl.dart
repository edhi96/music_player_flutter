import 'package:dartz/dartz.dart';
import 'package:music_player_flutter/features/home/data/model/music_table.dart';

import '../../../../common/failure.dart';
import '../../domain/repositories/detail_music_repository.dart';
import '../datasources/favourite_local_ds.dart';

class DetailMusicRepositoryImpl implements DetailMusicRepository {
  final FavouriteLocalDataSource favouriteLocalDataSource;
  DetailMusicRepositoryImpl({
    required this.favouriteLocalDataSource,
  });

  @override
  Future<Either<Failure, String>> addToFavourite(MusicTable data) async {
    try {
      final result = await favouriteLocalDataSource.insertFavourite(data);
      return Right(result);
    } on Exception catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MusicTable?>> isAddedToFavourite(int? id) async {
    try {
      final result = await favouriteLocalDataSource.getFavouriteById(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> removeFromFavourite(MusicTable data) async {
    try {
      final result = await favouriteLocalDataSource.removeFavourite(data);
      return Right(result);
    } on Exception catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
