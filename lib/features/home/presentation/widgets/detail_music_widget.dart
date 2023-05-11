import 'package:flutter/material.dart';
import 'package:music_player_flutter/features/home/domain/entities/music_entity.dart';
import 'package:music_player_flutter/features/home/presentation/provider/search_notifier.dart';
import 'package:provider/provider.dart';

import '../../../../common/styles.dart';
import '../../../../component/audio_widget.dart';
import '../provider/audio_provider.dart';
import '../provider/detail_notifier.dart';
import 'detail_image_music.dart';
import 'detail_info_music_widget.dart';

class DetailMusicWidget extends StatelessWidget {
  final MusicEntity? entity;
  final String? flow;

  const DetailMusicWidget({Key? key, required this.flow, required this.entity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MusicEntity musicEntity = entity ??
        const MusicEntity(
            id: 1, artist: 'Test', url: '', cover: '', title: 'Test Dummy', trackTimeMillis: 2, artistUrl: '', releaseDate: '', longDescription: '');

    bool statusFavourite = context.watch<DetailNotifier>().statusFavourite;
    List<MusicEntity> lstMusic = [];
    if (flow == 'favourite') {
      lstMusic = Provider.of<SearchNotifier>(context, listen: false).listFavourite;
      lstMusic.sort((a, b) => a.id.compareTo(b.id));
    }
    return _successLayout(context, musicEntity, statusFavourite, flow == 'favourite' ? lstMusic : [musicEntity]);
  }

  _successLayout(context, MusicEntity musicEntity, statusFavourite, List<MusicEntity> lstMusic) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          primary: true,
          child: Column(
            children: [
              Stack(
                fit: StackFit.loose,
                alignment: Alignment.topCenter,
                children: [
                  DetailImageMusic(
                    urlImage: musicEntity.cover,
                  ),
                  _appBar(context, statusFavourite, musicEntity),
                  Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.415,
                    ),
                    child: DetailInfoMusicWidget(
                      musicEntity: musicEntity,
                    ),
                  ),
                  Consumer<AudioProvider>(builder: (context, audioProvider, child) {
                    return audioProvider.isPlayed == false && audioProvider.isPaused == false
                        ? Positioned(
                            top: MediaQuery.of(context).size.height * 0.325,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.zero,
                              decoration: const BoxDecoration(color: AppColors.greenColor, shape: BoxShape.circle),
                              child: IconButton(
                                onPressed: () async {
                                  await Provider.of<AudioProvider>(context, listen: false).playSource(entity!, lstMusic, SourceMusic.search);
                                },
                                icon: Consumer<AudioProvider>(builder: (context, audioProvider, child) {
                                  return Icon(
                                    (audioProvider.music != null && audioProvider.music!.id == entity?.id && audioProvider.isPlayed == true)
                                        ? Icons.music_note_rounded
                                        : Icons.play_arrow_rounded,
                                    color: AppColors.yellowColor,
                                    size: 34,
                                  );
                                }),
                              ),
                            ),
                          )
                        : const SizedBox();
                  }),
                  Consumer<AudioProvider>(builder: (context, audioProvider, child) {
                    return audioProvider.isPlayed == true || audioProvider.isPaused == true
                        ? Positioned(
                            top: MediaQuery.of(context).size.height * 0.175,
                            left: 0,
                            right: 0,
                            child: const AudioWidget(),
                          )
                        : const SizedBox();
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _appBar(BuildContext context, bool statusFavourite, MusicEntity entity) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: AppColors.greenColor,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(4),
              child: const Icon(
                Icons.navigate_before_rounded,
                size: 30,
                color: AppColors.whiteColor,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              if (statusFavourite == false) {
                await Provider.of<DetailNotifier>(context, listen: false).addToFavourite(entity);
              } else {
                await Provider.of<DetailNotifier>(context, listen: false).removeFavourite(entity);
              }
              final message = context.read<DetailNotifier>().favouriteMessage;
              _showToast(context, message);
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: AppColors.greenColor,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(4),
              child: statusFavourite
                  ? const Icon(
                      Icons.favorite_rounded,
                      size: 30,
                      color: AppColors.whiteColor,
                    )
                  : const Icon(
                      Icons.favorite_border_rounded,
                      size: 30,
                      color: AppColors.whiteColor,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _showToast(BuildContext context, message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text('$message'),
      ),
    );
  }
}
