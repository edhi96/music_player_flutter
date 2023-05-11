import 'package:flutter/material.dart';

import '../../../../common/styles.dart';
import '../../domain/entities/music_entity.dart';

class DetailInfoMusicWidget extends StatelessWidget {
  final MusicEntity? musicEntity;

  const DetailInfoMusicWidget({Key? key, required this.musicEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _detailFoodWidget(context);
  }

  _detailFoodWidget(context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          Text(
            musicEntity?.title ?? '',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.blackColor,
                ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            color: Colors.grey,
            height: 10,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Artist : ${musicEntity?.artist}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.blackColor,
                    ),
              ),
              Text(
                'Release : ${musicEntity?.releaseDate}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.greenColor,
                    ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            color: Colors.grey,
            height: 10,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            musicEntity?.longDescription.isNotEmpty == true ? musicEntity!.longDescription : '-',
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.grayColor,
                ),
          ),
        ],
      ),
    );
  }
}
