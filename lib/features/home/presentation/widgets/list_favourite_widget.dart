import 'package:flutter/material.dart';
import 'package:music_player_flutter/features/home/domain/entities/music_entity.dart';
import 'package:music_player_flutter/features/home/presentation/pages/detail_music_page.dart';
import 'package:music_player_flutter/features/home/presentation/widgets/item_music.dart';
import 'package:provider/provider.dart';

import '../../../../common/state_enum.dart';
import '../../../../route/route_names.dart';
import '../provider/search_notifier.dart';

class ListFavouriteWidget extends StatelessWidget {
  const ListFavouriteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchNotifier>(builder: (context, data, child) {
      final state = data.listFavouriteState;
      if (state == RequestState.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state == RequestState.loaded) {
        return _gridFavouriteList(data.listFavourite);
      } else {
        return Center(
          child: Text(
            data.message,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.red,
                ),
          ),
        );
      }
    });
  }

  _gridFavouriteList(List<MusicEntity> listMusic) {
    return GridView.builder(
        primary: false,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: listMusic.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, RouteNames.detailMusicRoute,
                  arguments: {'argument': DetailMusicPageArgument(listMusic[index], 'favourite')}).then((value) {
                Future.microtask(() => Provider.of<SearchNotifier>(context, listen: false).fetchListFavourite());
              });
            },
            child: ItemMusic(
              entity: listMusic[index],
              listMusic: listMusic,
            ),
          );
        });
  }
}
