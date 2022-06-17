import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:task_reminder/view_models/start_up_view_model.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).primaryColor,
    ));

    return ViewModelBuilder<StartUpViewModel>.reactive(
      viewModelBuilder: () => StartUpViewModel(),
      onModelReady: (model) => model.initViews(context),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Image.asset(
                'assets/icons/arsi_text_logo.png',
                width: 400,
                height: 400,
              ),
              // verticalSpaceSmall,
              // CircularProgressIndicator(
              //     backgroundColor: PrimaryColor,
              //     strokeWidth: 5,
              //     valueColor: AlwaysStoppedAnimation(
              //       InfoColor,
              //     ))
            ])),
      ),
    );
  }
}
