import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

enum FastAccesTransition {
  fadeThrough,
  xAxis,
}

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

@immutable
class TransitionCoverSettings {
  final FastAccesTransition transition;
  final bool reversed;
  final Duration transitionDuration;

  const TransitionCoverSettings(
      {this.transition = FastAccesTransition.fadeThrough,
      this.reversed = false,
      this.transitionDuration = const Duration(milliseconds: 500)});
}

class TransitionCover extends StatefulWidget {
  const TransitionCover(
      {super.key,
      TransitionCoverSettings? transitionCoverSettings,
      required this.child})
      : transitionCoverSettings = transitionCoverSettings ?? const TransitionCoverSettings();
  final TransitionCoverSettings transitionCoverSettings;
  final Widget child;

  @override
  State<TransitionCover> createState() => _TransitionCoverState();
}

class _TransitionCoverState extends State<TransitionCover> {
  Widget mainChild = const SizedBox();

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      setState(() {
        mainChild = widget.child;
      });
    });
    return PageTransitionSwitcher(
      reverse: widget.transitionCoverSettings.reversed,
      duration: widget.transitionCoverSettings.transitionDuration,
      child: mainChild,
      transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
        return fastAccesTransition(
          child,
          primaryAnimation,
          secondaryAnimation,
          widget.transitionCoverSettings.transition,
        );
      },
    );
  }
}
