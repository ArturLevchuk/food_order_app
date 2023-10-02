
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LikeAnimatedIcon extends StatelessWidget {
  const LikeAnimatedIcon({
    super.key,
    required this.size,
    required this.animationController,
  });

  final double size;

  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.w,
      height: size.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            color: Theme.of(context).primaryColor,
            size: size.w,
          ),
          AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return Icon(
                Icons.favorite,
                color: Theme.of(context).primaryColor,
                size: (size * animationController.value).w,
              );
            },
          ),
        ],
      ),
    );
  }
}
