import 'package:flutter/material.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';
import 'package:task_reminder/views/shared/ui_colors.dart';
import 'package:task_reminder/views/shared/ui_helpers.dart';

class LoadingIndicator extends StatelessWidget {
  final bool isLoading;
  final String? loadingLabel;
  final Widget child;

  LoadingIndicator(
      {required this.isLoading, this.loadingLabel, required this.child});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return LoadingOverlayPro(
      isLoading: isLoading,
      progressIndicator: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffe7f5f6),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                    backgroundColor: PrimaryColor,
                    strokeWidth: 5,
                    valueColor: AlwaysStoppedAnimation(
                      InfoColor,
                    )),
                verticalSpaceTiny,
                Text(loadingLabel ?? "Loading...",
                    style: const TextStyle(color: Colors.black, fontSize: 14)),
              ])),
      child: child,
    );
  }
}
