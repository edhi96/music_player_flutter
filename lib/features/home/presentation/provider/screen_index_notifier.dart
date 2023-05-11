import 'package:flutter/material.dart';
import 'package:music_player_flutter/features/home/presentation/pages/favourite_page.dart';

import '../pages/music_list_page.dart';

class ScreenIndexNotifier extends ChangeNotifier {
  final List<Widget> widgetOptions = <Widget>[
    const MusicListPage(),
    const FavouritePage(),
  ];

  int _screenIndex = 0;
  int get currentIndex => _screenIndex;

  void updateScreenIndex(int newIndex) {
    _screenIndex = newIndex;
    notifyListeners();
  }
}
