import 'package:flutter/material.dart';

import '../../../../common/styles.dart';
import '../widgets/list_music_widget.dart';
import '../widgets/search_widget.dart';

class MusicListPage extends StatelessWidget {
  const MusicListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi!',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.blueColor),
                    ),
                    Text(
                      'Recommendation music for you!',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.blackColor),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            _bodyLayout(),
          ],
        ),
      ),
    );
  }

  _bodyLayout() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        primary: true,
        physics: const ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(
              height: 20,
            ),
            SearchWidget(),
            SizedBox(
              height: 20,
            ),
            ListMusicWidget()
          ],
        ),
      ),
    );
  }
}
