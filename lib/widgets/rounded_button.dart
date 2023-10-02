import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.onTap,
    required this.buttonName,
    this.fontSize = 16,
  });

  final double fontSize;
  final Function() onTap;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        // padding: MaterialStatePropertyAll(EdgeInsets.zero),
        padding: MaterialStatePropertyAll(
          const EdgeInsets.symmetric(vertical: 9).r,
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.5).r,
          ),
        ),
        backgroundColor:
            MaterialStatePropertyAll(Theme.of(context).primaryColor),
      ),
      child: FittedBox(
        child: Text(
          buttonName,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: fontSize.sp,
          ),
        ),
      ),
    );
  }
}
