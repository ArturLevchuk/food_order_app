import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

enum FastAccesTransition { fadeThrough, xAxis }

Widget fastAccesTransition(Widget child, Animation<double> primaryAnimation,
    Animation<double> secondaryAnimation, FastAccesTransition transition) {
  switch (transition) {
    case FastAccesTransition.xAxis:
      return SharedAxisTransition(
        animation: primaryAnimation,
        secondaryAnimation: secondaryAnimation,
        transitionType: SharedAxisTransitionType.horizontal,
        child: child,
      );
    case FastAccesTransition.fadeThrough:
      return FadeThroughTransition(
        animation: primaryAnimation,
        secondaryAnimation: secondaryAnimation,
        child: child,
      );
  }
}
