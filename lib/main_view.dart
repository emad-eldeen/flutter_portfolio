import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:portfolio/common/page_transition.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key, required this.controller}) : super(key: key);
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      // running on the web!
      // special listener for the web which listens for mouse wheel, or touchpad
      return Listener(
        onPointerSignal: (pointerSignal) {
          if (pointerSignal is PointerScrollEvent) {
            if (pointerSignal.scrollDelta.dy > 0) {
              // scroll down
              controller.nextPage(
                duration: PageTransition.duration,
                curve: PageTransition.curve,
              );
            } else if (pointerSignal.scrollDelta.dy < 0) {
              // scroll up
              controller.previousPage(
                duration: PageTransition.duration,
                curve: PageTransition.curve,
              );
            }
          }
        },
        child: PageView(
          // this line is to disable the default scrolling behaviour which
          // prevented snapping in web
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          pageSnapping: false,
          controller: controller,
          children: const <Widget>[
            Center(
              child: Text('First Page'),
            ),
            Center(
              child: Text('Second Page'),
            ),
            Center(
              child: Text('Third Page'),
            )
          ],
        ),
      );
    } else {
      // NOT running on the web. i.e., mobile
      return PageView(
        scrollDirection: Axis.vertical,
        controller: controller,
        children: const <Widget>[
          Center(
            child: Text('First Page'),
          ),
          Center(
            child: Text('Second Page'),
          ),
          Center(
            child: Text('Third Page'),
          )
        ],
      );
    }
  }
}
