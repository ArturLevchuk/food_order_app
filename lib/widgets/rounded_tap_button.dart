import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedTabButton extends StatelessWidget {
  const RoundedTabButton({
    super.key,
    required this.text,
    required this.isActive,
    required this.onTap,
    this.fontSize = 16,
    this.fontWeight,
  });

  final String text;
  final bool isActive;
  final Function() onTap;
  final double fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 4,
        ).r,
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context).primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 1.5,
            color: Theme.of(context).primaryColor,
          ),
        ),
        duration: const Duration(milliseconds: 250),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.white : Theme.of(context).primaryColor,
            fontSize: fontSize.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
