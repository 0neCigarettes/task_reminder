import 'package:flutter/material.dart';
import 'package:task_reminder/routes/route_name.dart';
import 'package:task_reminder/views/home_view.dart';
import 'package:task_reminder/views/start_up_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case startUpView:
      return _pageRoute(
        routeName: settings.name,
        viewToShow: const StartUpView(),
      );
    case homeView:
      return _pageRoute(
        routeName: settings.name,
        viewToShow: const HomeView(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text(
              'No route defined for ${settings.name}',
            ),
          ),
        ),
      );
  }
}

PageRoute _pageRoute({String? routeName, Widget? viewToShow}) {
  return MaterialPageRoute(
    settings: RouteSettings(name: routeName),
    builder: (_) => viewToShow!,
  );
}
