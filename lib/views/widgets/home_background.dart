import 'package:flutter/material.dart';

class HomeBackground extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets padding;

  HomeBackground(
      {this.children = const <Widget>[],
      this.padding = const EdgeInsets.only(bottom: 20)});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // Background
            Positioned(
              child: Image.asset(
                "assets/images/backgrounds/bg.png",
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              ),
            ),

            //logo
            Positioned(
              top: 25,
              child: Image.asset("assets/icons/arsi_text_logo.png",
                  width: size.width * 0.70),
            ),

            //device
            Positioned(
              top: 120,
              child: Image.asset("assets/images/backgrounds/device.png",
                  width: size.width * 0.60),
            ),

            //person left
            Positioned(
              top: 92,
              left: 0,
              child: Image.asset("assets/images/backgrounds/person_1.png",
                  width: size.width * 0.40),
            ),

            //notice
            Positioned(
              top: 325,
              left: 35,
              child: Image.asset(
                "assets/images/backgrounds/notice_presensi.png",
                width: size.width * 0.50,
              ),
            ),

            //personRight
            Positioned(
              top: 265,
              right: 65,
              child: Image.asset("assets/images/backgrounds/person_2.png",
                  width: size.width * 0.40),
            ),
            Padding(
                padding: padding,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: children))
          ],
        ));
  }
}
