import 'package:flutter/material.dart';
import 'package:music_player_flutter/features/home/domain/entities/music_entity.dart';

import '../../domain/usecases/add_to_favourite_use_case.dart';
import '../../domain/usecases/get_status_favourite_use_case.dart';
import '../../domain/usecases/remove_favourite_use_case.dart';

class DetailNotifier extends ChangeNotifier {
  static const favouriteAddSuccessMessage = 'Added to Favourite';
  static const favouriteRemoveSuccessMessage = 'Removed from Favourite';
  late bool _statusFavourite = false;

  bool get statusFavourite => _statusFavourite;

  String _favouriteMessage = '';

  String get favouriteMessage => _favouriteMessage;

  DetailNotifier({
    required GetStatusFavouriteUseCase statusFavouriteUseCase,
    required AddToFavouriteUseCase addToFavouriteUseCase,
    required RemoveFavouriteUseCase removeFavouriteUseCase,
  })  : _statusFavouriteUseCase = statusFavouriteUseCase,
        _removeFavouriteUseCase = removeFavouriteUseCase,
        _addToFavouriteUseCase = addToFavouriteUseCase;

  final GetStatusFavouriteUseCase _statusFavouriteUseCase;
  final AddToFavouriteUseCase _addToFavouriteUseCase;
  final RemoveFavouriteUseCase _removeFavouriteUseCase;

  Future<void> fetchStatusFavouriteMusic(int? id) async {
    final result = await _statusFavouriteUseCase.execute(id);
    _statusFavourite = result;
    notifyListeners();
  }

  Future<void> addToFavourite(MusicEntity entity) async {
    final result = await _addToFavouriteUseCase.execute(entity);
    _favouriteMessage = result;
    await fetchStatusFavouriteMusic(entity.id);
  }

  Future<void> removeFavourite(MusicEntity entity) async {
    final result = await _removeFavouriteUseCase.execute(entity);
    _favouriteMessage = result;
    await fetchStatusFavouriteMusic(entity.id);
  }
}
