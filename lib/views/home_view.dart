import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:stacked/stacked.dart';
import 'package:task_reminder/view_models/home_view_model.dart';
import 'package:task_reminder/views/shared/ui_buttons.dart';
import 'package:task_reminder/views/shared/ui_colors.dart';
import 'package:task_reminder/views/shared/ui_helpers.dart';
import 'package:task_reminder/views/widgets/home_background.dart';
import 'package:task_reminder/views/widgets/loading_indicator.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    FlutterBackgroundService()
        .on('start')
        .listen((result) => {debugPrint("Stream: ${result!['current_date']}")});

    // Lock Orientation Portait Only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).primaryColor,
    ));

    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.initViews(context),
      builder: (context, model, child) => Scaffold(
          backgroundColor: LightColor,
          body: LoadingIndicator(
              loadingLabel: model.LoadingText,
              isLoading: model.isBusy,
              child: HomeBackground(
                  padding: const EdgeInsets.only(bottom: 50),
                  children: <Widget>[
                    roundedIconButton(
                        onPressed: () {
                          model.onPowerClick();
                        },
                        primaryColor: Colors.transparent,
                        onSwitch: model.switchVal),
                    verticalSpaceTiny,
                    Text(
                      "Sudah presensi hari ini ?",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                    verticalSpaceTiny,
                    Text(
                      "pastikan presensi anda terdata !",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38),
                    ),
                    verticalSpaceMedium,
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      textButtonOutlined(
                        onPressed: () => model.onAbsentClick(context),
                        text: 'sudah presensi',
                      ),
                      horizontalSpaceMedium,
                      textButtonOutlined(
                        onPressed: () {
                          model.onLinkPresentClick(context);
                        },
                        text: 'belum presensi',
                        foregroundColor: DangerColor,
                        outlineColor: DangerColor,
                      ),
                    ])
                  ]))),
    );
  }
}
