import 'package:flutter/material.dart';
import 'package:music_player_flutter/features/home/domain/entities/music_entity.dart';
import 'package:provider/provider.dart';

import '../../../../common/state_enum.dart';
import '../../../../route/route_names.dart';
import '../pages/detail_music_page.dart';
import '../provider/search_notifier.dart';
import 'item_music.dart';

class ListMusicWidget extends StatelessWidget {
  const ListMusicWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchNotifier>(builder: (context, data, child) {
      final state = data.searchMusicState;
      if (state == RequestState.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state == RequestState.loaded) {
        return _gridListWidget(data.listMusic);
      } else {
        return Center(
          child: Text(
            'Error : ${data.message}',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.red,
                ),
          ),
        );
      }
    });
  }

  _gridListWidget(List<MusicEntity> listMusic) {
    return GridView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: listMusic.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, RouteNames.detailMusicRoute, arguments: {'argument': DetailMusicPageArgument(listMusic[index], 'home')})
                .then((value) {
              Future.microtask(() => Provider.of<SearchNotifier>(context, listen: false).fetchListFavourite());
            });
          },
          child: ItemMusic(
            entity: listMusic[index],
            listMusic: listMusic,
          ),
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    );
  }
}
