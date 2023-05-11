import 'package:dartz/dartz.dart';
import 'package:music_player_flutter/features/home/data/model/music_table.dart';

import '../../../../common/failure.dart';
import '../../data/model/music_model.dart';
import '../../data/model/music_response.dart';

abstract class HomeRepository {
  Future<Either<Failure, MusicResponse<MusicModel>>> getSearchMusic(String? q);
  Future<Either<Failure, List<MusicTable>>> getListFavourite();
}
