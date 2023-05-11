import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/styles.dart';
import '../../../../component/audio_widget.dart';
import '../provider/screen_index_notifier.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screenIndexProvider = Provider.of<ScreenIndexNotifier>(context);
    int currentScreenIndex = screenIndexProvider.currentIndex;
    var widgetOptions = screenIndexProvider.widgetOptions;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        elevation: 5,
        currentIndex: currentScreenIndex,
        backgroundColor: AppColors.greenColor,
        selectedIconTheme: const IconThemeData(color: AppColors.whiteColor),
        unselectedIconTheme: const IconThemeData(color: AppColors.grayColor),
        selectedItemColor: AppColors.whiteColor,
        unselectedItemColor: AppColors.grayColor,
        onTap: (value) {
          screenIndexProvider.updateScreenIndex(value);
        },
        items: [
          BottomNavigationBarItem(
              label: 'Home', icon: Icon((currentScreenIndex == 0) ? Icons.home : Icons.home_outlined), backgroundColor: AppColors.greenColor),
          BottomNavigationBarItem(
            label: 'Favourite',
            icon: Icon((currentScreenIndex == 1) ? Icons.favorite : Icons.favorite_outline),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          widgetOptions[currentScreenIndex],
          const Align(
            alignment: Alignment.bottomCenter,
            child: AudioWidget(),
          ),
        ],
      ),
    );
  }
}
