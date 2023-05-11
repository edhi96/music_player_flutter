import 'package:flutter/material.dart';

import '../widgets/list_favourite_widget.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 10),
        child: const ListFavouriteWidget(),
      ),
    );
  }
}
