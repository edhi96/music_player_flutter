import 'package:flutter/material.dart';
import 'package:music_player_flutter/features/home/domain/entities/music_entity.dart';
import 'package:provider/provider.dart';

import '../../../../common/styles.dart';
import '../../../../component/image_widget.dart';
import '../provider/audio_provider.dart';

class ItemMusic extends StatelessWidget {
  final MusicEntity? entity;
  final List<MusicEntity> listMusic;

  const ItemMusic({
    Key? key,
    required this.entity,
    required this.listMusic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return itemMusic(entity, context);
  }

  itemMusic(MusicEntity? musicEntity, context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.black,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ImageWidget(
            imageUrl: '${musicEntity?.cover}',
            width: 185,
            height: 185,
            borderRadiusGeometry: BorderRadius.circular(12),
            fit: BoxFit.fill,
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              decoration: const BoxDecoration(color: AppColors.greenColor, shape: BoxShape.circle),
              child: IconButton(
                onPressed: () async => await Provider.of<AudioProvider>(context, listen: false).playSource(entity!, listMusic, SourceMusic.search),
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
          ),
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    musicEntity?.artist ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700, color: AppColors.whiteColor),
                  ),
                  Text(
                    ' ${musicEntity?.title}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700, color: AppColors.yellowColor),
                  ),
                  Text(
                    'release : ${musicEntity?.releaseDate}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700, color: AppColors.whiteColor),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
