import 'package:dartz/dartz.dart';
import 'package:music_player_flutter/features/home/data/model/music_table.dart';

import '../../../../common/failure.dart';

abstract class DetailMusicRepository {
  Future<Either<Failure, String>> addToFavourite(MusicTable data);
  Future<Either<Failure, String>> removeFromFavourite(MusicTable data);
  Future<Either<Failure, MusicTable?>> isAddedToFavourite(int id);
}
