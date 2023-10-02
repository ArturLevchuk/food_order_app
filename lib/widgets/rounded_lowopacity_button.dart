import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_order_app/widgets/like_animated_icon.dart';

Widget roundedLowOpacityCover(
    {required Function() onTap, required double size, required Widget child}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      splashColor: Colors.black,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        // padding: const EdgeInsets.all(10),
        width: size.w,
        height: size.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white.withOpacity(.7),
          border: Border.all(
            width: 1,
            color: const Color(0xFFC1C1C1),
          ),
        ),
        child: child,
      ),
    ),
  );
}

class RoundedLowOpacityButton extends StatelessWidget {
  const RoundedLowOpacityButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.size = 36,
  });

  final Function() onTap;
  final Icon icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return roundedLowOpacityCover(
      onTap: onTap,
      size: size,
      child: FittedBox(
        fit: BoxFit.none,
        child: icon,
      ),
    );
  }
}

class RoundedLowOpacityButtonAnimated extends StatefulWidget {
  const RoundedLowOpacityButtonAnimated({
    super.key,
    required this.onTap,
    this.size = 36,
  });

  final Function() onTap;
  final double size;

  @override
  State<RoundedLowOpacityButtonAnimated> createState() =>
      _RoundedLowOpacityButtonAnimatedState();
}

class _RoundedLowOpacityButtonAnimatedState
    extends State<RoundedLowOpacityButtonAnimated>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return roundedLowOpacityCover(
      onTap: () {
        if (_animationController.value == 0) {
          _animationController.forward();
        } else if (_animationController.value == 1) {
          _animationController.reverse();
        }
        widget.onTap();
      },
      size: widget.size,
      child: FittedBox(
        alignment: Alignment.center,
        fit: BoxFit.none,
        child: LikeAnimatedIcon(
          size: 20,
          animationController: _animationController,
        ),
      ),
    );
  }
}
