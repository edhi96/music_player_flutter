import 'package:dartz/dartz.dart';
import 'package:music_player_flutter/features/home/data/model/music_table.dart';

import '../../../../common/failure.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/favourite_local_ds.dart';
import '../datasources/home_remote_ds.dart';
import '../model/music_model.dart';
import '../model/music_response.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final FavouriteLocalDataSource favouriteLocalDataSource;
  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.favouriteLocalDataSource,
  });

  @override
  Future<Either<Failure, MusicResponse<MusicModel>>> getSearchMusic(String? q) async {
    try {
      final result = await remoteDataSource.search(q ?? '');
      return Right(result);
    } on Exception catch (e) {
      if (e.toString().contains('Failed host')) {
        return const Left(GeneralFailure('Failed to connect to the network'));
      } else {
        return Left(GeneralFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<MusicTable>>> getListFavourite() async {
    try {
      final result = await favouriteLocalDataSource.getListFavourite();
      return Right(result);
    } on Exception catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
