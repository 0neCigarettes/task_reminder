import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:task_reminder/locator.dart';
import 'package:task_reminder/routes/route_name.dart';
import 'package:task_reminder/services/navigation_service.dart';
import 'package:task_reminder/view_models/base_view_model.dart';

class StartUpViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  Future initViews(BuildContext context) async {
    FlutterNativeSplash.remove();
    await startTimer();
  }

  startTimer() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, handleStartUpLogic);
  }

  Future handleStartUpLogic() async {
    _navigationService.replaceTo(homeView);
  }
}
