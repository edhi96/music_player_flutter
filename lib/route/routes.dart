import 'package:flutter/material.dart';

import '../features/home/presentation/pages/detail_music_page.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/home/presentation/pages/splash_page.dart';
import 'route_names.dart';

class RoutesSetting {
  Route onRoute(RouteSettings settings) {
    var routes = <String, WidgetBuilder>{
      RouteNames.splashRoute: (context) => const SplashPage(),
      RouteNames.homeRoute: (context) => const HomePage(),
      RouteNames.detailMusicRoute: (context) => const DetailMusicPage(),
    };
    WidgetBuilder? builder = routes[settings.name];
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, __, ___) => builder!(context),
      transitionsBuilder: (context, animation, _, child) {
        const curve = Curves.bounceInOut;
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).chain(CurveTween(curve: curve)).animate(animation),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
    );
  }
}
