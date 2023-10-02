import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8).r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12).r,
          color: const Color(0xFFE9E9E9),
          border: Border.all(
            width: 1,
            color: const Color(0xFFC1C1C1),
          ),
        ),
        child: Row(
          children: [
            SizedBox.square(
              dimension: 24.w,
              child: SvgPicture.asset("assets/icons/akar-icons_search.svg"),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: TextField(
                onTapOutside: (_) {
                  FocusScope.of(context).unfocus();
                },
                cursorColor: Theme.of(context).primaryColor,
                decoration: const InputDecoration.collapsed(
                    hintText: "Введіть назву вашої страви"),
                style: TextStyle(
                  color: const Color(0xFF515151),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
