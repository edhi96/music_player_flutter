import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:music_player_flutter/features/home/presentation/provider/search_notifier.dart';
import 'package:music_player_flutter/route/routes.dart';
import 'package:provider/provider.dart';

import 'common/styles.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/home/presentation/provider/audio_provider.dart';
import 'features/home/presentation/provider/screen_index_notifier.dart';
import 'main_module.dart';

final locator = GetIt.instance;

void main() async {
  MainModule.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ScreenIndexNotifier()),
        ChangeNotifierProvider(create: (context) => locator<AudioProvider>()),
        ChangeNotifierProvider(
          create: (_) => locator<SearchNotifier>()
            ..fetchSearch('')
            ..fetchListFavourite(),
        ),
      ],
      child: MaterialApp(
        title: 'Music App',
        theme: ThemeData(textTheme: myTextTheme),
        initialRoute: '/splash',
        onGenerateRoute: RoutesSetting().onRoute,
        home: const HomePage(),
      ),
    );
  }
}
