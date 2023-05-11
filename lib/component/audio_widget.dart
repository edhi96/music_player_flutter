import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/styles.dart';
import '../features/home/presentation/provider/audio_provider.dart';
import 'image_widget.dart';

class AudioWidget extends StatelessWidget {
  const AudioWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return audioPlayerWidget(context);
  }

  Widget audioPlayerWidget(context) {
    Size size = MediaQuery.of(context).size;
    return Dismissible(
      direction: DismissDirection.startToEnd,
      key: UniqueKey(),
      onDismissed: (direction) async => Provider.of<AudioProvider>(context, listen: false).clean(),
      child: Consumer<AudioProvider>(builder: (context, audioProvider, child) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          child: (audioProvider.isPlayed || audioProvider.isPaused)
              ? Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        width: size.width * 0.9,
                        decoration: BoxDecoration(color: AppColors.greenColor.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 10, top: 7),
                                  child: ImageWidget(
                                    imageUrl: audioProvider.cover ?? '',
                                    width: 40,
                                    height: 40,
                                    shape: BoxShape.rectangle,
                                    borderRadiusGeometry: BorderRadius.circular(10),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10, top: 7),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          audioProvider.title ?? '',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge
                                              ?.copyWith(fontWeight: FontWeight.w700, color: AppColors.yellowColor),
                                        ),
                                        Text(
                                          audioProvider.artist ?? '',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge
                                              ?.copyWith(fontWeight: FontWeight.w700, color: AppColors.yellowColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 7, right: 7),
                                  child: GestureDetector(
                                    onTap: () async {
                                      await audioProvider.stop();
                                    },
                                    child: const Icon(
                                      Icons.close_rounded,
                                      color: AppColors.yellowColor,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            StreamProvider<Duration>(
                              create: (_) => audioProvider.audioPlayer.positionStream,
                              initialData: const Duration(),
                              builder: (context, child) {
                                int seconds = Provider.of<Duration>(context).inSeconds.toInt();
                                int minutes = Provider.of<Duration>(context).inMinutes.toInt();
                                return Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '$minutes:$seconds',
                                    style:
                                        Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700, color: AppColors.yellowColor),
                                  ),
                                );
                              },
                            ),
                            Container(
                              padding: EdgeInsets.zero,
                              margin: const EdgeInsets.only(left: 10, right: 10),
                              child: StreamProvider<Duration>(
                                create: (_) => audioProvider.audioPlayer.positionStream,
                                initialData: const Duration(),
                                builder: (context, child) {
                                  double sliderValue = (audioProvider.audioPlayer.duration?.inMilliseconds.toDouble() ?? 1.toDouble()) <
                                          Provider.of<Duration>(context).inMilliseconds.toDouble()
                                      ? (audioProvider.audioPlayer.duration?.inMilliseconds.toDouble() ?? 1.toDouble())
                                      : Provider.of<Duration>(context).inMilliseconds.toDouble();

                                  return Slider(
                                    thumbColor: AppColors.blueColor,
                                    activeColor: AppColors.blueColor,
                                    inactiveColor: Colors.white.withOpacity(0.7),
                                    min: 0,
                                    max: (audioProvider.audioPlayer.duration?.inMilliseconds.toDouble() ?? 1.toDouble()),
                                    value: sliderValue,
                                    onChanged: (value) async {
                                      await audioProvider.seek(Duration(milliseconds: value.toInt()));
                                    },
                                  );
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10, right: 7),
                                  padding: EdgeInsets.zero,
                                  child: GestureDetector(
                                    onTap: () async {
                                      await audioProvider.previous();
                                    },
                                    child: const Icon(
                                      Icons.skip_previous_rounded,
                                      size: 40,
                                      color: AppColors.yellowColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 15),
                                  padding: EdgeInsets.zero,
                                  decoration: const BoxDecoration(color: AppColors.greenColor, shape: BoxShape.circle),
                                  child: StreamProvider<Duration>(
                                    create: (_) => audioProvider.audioPlayer.positionStream,
                                    initialData: const Duration(),
                                    builder: (context, child) {
                                      double sliderValue = (audioProvider.audioPlayer.duration?.inMilliseconds.toDouble() ?? 1.toDouble()) <
                                              Provider.of<Duration>(context).inMilliseconds.toDouble()
                                          ? (audioProvider.audioPlayer.duration?.inMilliseconds.toDouble() ?? 1.toDouble())
                                          : Provider.of<Duration>(context).inMilliseconds.toDouble();
                                      double maxSliderValue = audioProvider.audioPlayer.duration?.inMilliseconds.toDouble() ?? 1.toDouble();
                                      IconData icon = audioProvider.isPlayed ? Icons.pause_rounded : Icons.play_arrow_rounded;
                                      if (sliderValue == maxSliderValue) {
                                        if (audioProvider.isPlayed) {
                                          audioProvider.next();
                                        }
                                      }
                                      return IconButton(
                                        onPressed: () async {
                                          if (sliderValue == maxSliderValue) {
                                            await audioProvider.seek(const Duration());
                                            return audioProvider.play();
                                          }
                                          (audioProvider.isPlayed ? audioProvider.pause : audioProvider.play)();
                                        },
                                        icon: Icon(
                                          icon,
                                          color: AppColors.yellowColor,
                                          size: 33,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 7, bottom: 10),
                                  padding: EdgeInsets.zero,
                                  child: GestureDetector(
                                    onTap: () async {
                                      await audioProvider.next();
                                    },
                                    child: const Icon(
                                      Icons.skip_next_rounded,
                                      size: 40,
                                      color: AppColors.yellowColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        );
      }),
    );
  }
}
