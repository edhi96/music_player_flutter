import 'package:music_player_flutter/features/home/data/model/music_table.dart';

import 'database_helper.dart';

abstract class FavouriteLocalDataSource {
  Future<String> insertFavourite(MusicTable table);
  Future<String> removeFavourite(MusicTable table);
  Future<List<MusicTable>> getListFavourite();
  Future<MusicTable?> getFavouriteById(int? id);
}

class FavouriteLocalDataSourceImpl implements FavouriteLocalDataSource {
  final DatabaseHelper databaseHelper;
  FavouriteLocalDataSourceImpl({
    required this.databaseHelper,
  });

  @override
  Future<List<MusicTable>> getListFavourite() async {
    final result = await databaseHelper.getFavouriteList();
    return result.map((data) => MusicTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertFavourite(MusicTable table) async {
    try {
      await databaseHelper.insertFavourite(table);
      return 'Added to Favourite';
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<String> removeFavourite(MusicTable table) async {
    try {
      await databaseHelper.removeFavourite(table);
      return 'Removed from Favourite';
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<MusicTable?> getFavouriteById(int? id) async {
    final result = await databaseHelper.getFavoriteById(id);
    if (result != null) {
      return MusicTable.fromMap(result);
    } else {
      return null;
    }
  }
}
