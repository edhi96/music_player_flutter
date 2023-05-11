import 'package:flutter/material.dart';

import '../../../../common/styles.dart';
import '../../../../route/route_names.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.of(context).pushReplacementNamed(RouteNames.homeRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: _titleApp(),
      ),
    );
  }

  _titleApp() {
    return Text(
      "Music Player App",
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.greenColor),
    );
  }
}
