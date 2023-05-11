import 'package:flutter/material.dart';
import 'package:music_player_flutter/features/home/domain/entities/music_entity.dart';
import 'package:provider/provider.dart';

import '../../../../main.dart';
import '../provider/detail_notifier.dart';
import '../provider/search_notifier.dart';
import '../widgets/detail_music_widget.dart';

class DetailMusicPageArgument {
  final MusicEntity? entity;
  final String? flow;

  DetailMusicPageArgument(this.entity, this.flow);
}

class DetailMusicPage extends StatelessWidget {
  const DetailMusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    MusicEntity? entity = (ModalRoute.of(context)?.settings.arguments as Map<String, DetailMusicPageArgument>).values.first.entity;
    String? flow = (ModalRoute.of(context)?.settings.arguments as Map<String, DetailMusicPageArgument>).values.first.flow;
    return ChangeNotifierProvider(
      create: (_) => locator<SearchNotifier>()..fetchListFavourite(),
      child: ChangeNotifierProvider(
        create: (_) => locator<DetailNotifier>()..fetchStatusFavouriteMusic(entity?.id),
        child: _bodyLayout(context, entity, flow),
      ),
    );
  }

  _bodyLayout(context, MusicEntity? entity, String? flow) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<SearchNotifier>(builder: (context, data, child) {
        return Consumer<DetailNotifier>(builder: (context, data, child) {
          return DetailMusicWidget(entity: entity, flow: flow);
        });
      }),
    );
  }
}
