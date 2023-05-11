import 'package:flutter/material.dart';
import 'package:music_player_flutter/features/home/domain/entities/music_entity.dart';
import 'package:music_player_flutter/features/home/domain/usecases/search_music_use_case.dart';

import '../../../../../../../common/state_enum.dart';
import '../../domain/usecases/list_favourite_use_case.dart';

class SearchNotifier extends ChangeNotifier {
  var _listMusic = <MusicEntity>[];

  List<MusicEntity> get listMusic => _listMusic;
  RequestState _searchMusicState = RequestState.empty;
  RequestState get searchMusicState => _searchMusicState;

  String _message = '';
  String get message => _message;

  var _listFavourite = <MusicEntity>[];
  List<MusicEntity> get listFavourite => _listFavourite;
  RequestState _listFavouriteState = RequestState.empty;
  RequestState get listFavouriteState => _listFavouriteState;

  SearchNotifier({
    required SearchMusicUseCase searchMusicUseCase,
    required ListFavouriteUseCase listFavouriteUseCase,
  })  : _searchMusicUseCase = searchMusicUseCase,
        _listFavouriteUseCase = listFavouriteUseCase;

  final SearchMusicUseCase _searchMusicUseCase;
  final ListFavouriteUseCase _listFavouriteUseCase;

  void fetchListFavourite() async {
    _listFavouriteState = RequestState.loading;
    notifyListeners();
    final result = await _listFavouriteUseCase.execute();
    result.fold((failure) {
      _listFavouriteState = RequestState.error;
      _message = failure;
      notifyListeners();
    }, (resultFavourite) {
      _listFavouriteState = RequestState.loaded;
      _listFavourite = resultFavourite;
      notifyListeners();
    });
  }

  void fetchSearch(String? query) async {
    _searchMusicState = RequestState.loading;
    notifyListeners();

    final result = await _searchMusicUseCase.execute(query);
    result.fold(
      (failure) {
        _searchMusicState = RequestState.error;
        _message = failure;
        notifyListeners();
      },
      (musicData) {
        _searchMusicState = RequestState.loaded;
        _listMusic = musicData;
        notifyListeners();
      },
    );
  }
}
