import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedDialog extends StatelessWidget {
  const RoundedDialog({
    super.key,
    required this.children,
    this.width = 300,
  });

  final List<Widget> children;
  final double width;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      alignment: Alignment.center,
      fit: BoxFit.none,
      child: Material(
        borderRadius: BorderRadius.circular(16).r,
        child: Container(
          width: width.w,
          padding: EdgeInsets.all(15.w),
          child: Column(mainAxisSize: MainAxisSize.min, children: children),
        ),
      ),
    );
  }
}
