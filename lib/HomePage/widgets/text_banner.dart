import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextBanner extends StatelessWidget {
  const TextBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RPadding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 24),
      child: Text.rich(
        const TextSpan(
          text: "Замов та отримай свою піццу всього ",
          children: [
            TextSpan(
              text: "\nза 30 хвилин!",
              style: TextStyle(
                color: Color(0xFFFF0000),
              ),
            ),
          ],
        ),
        style: GoogleFonts.montserrat(
          fontSize: 32.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
