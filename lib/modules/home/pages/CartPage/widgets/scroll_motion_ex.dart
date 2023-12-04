import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ScrollMotionEx extends StatelessWidget {
  const ScrollMotionEx({
    Key? key,
    required this.callBack,
  }) : super(key: key);

  final Function(AnimationStatus status) callBack;

  @override
  Widget build(BuildContext context) {
    final paneData = ActionPane.of(context)!;
    final controller = Slidable.of(context)!;

    controller.animation.addStatusListener(callBack);

    // Each child starts just outside of the Slidable.
    final startOffset = Offset(paneData.alignment.x, paneData.alignment.y);

    final animation = controller.animation
        .drive(CurveTween(curve: Interval(0, paneData.extentRatio)))
        .drive(Tween(begin: startOffset, end: Offset.zero));

    return SlideTransition(
      position: animation,
      child: const BehindMotion(),
    );
  }
}
