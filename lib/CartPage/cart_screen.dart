import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static const routeName = '/cart_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Кошик",
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20).r,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Color(0x28000000),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
              borderRadius: BorderRadius.circular(16).r,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 85.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12).r,
                        child: SizedBox(
                          width: 138.w,
                          child: Image.asset(
                            "assets/images/bavarska.jpeg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Тревісо",
                              style: GoogleFonts.montserrat(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              width: 83.w,
                              padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 4)
                                  .r,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15).r,
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Text(
                                "Ø30",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              "220 грн.",
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                RPadding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Добавки: мазерати, чеддер, салямі, сулугуні, ",
                          style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(8).r,
                          splashColor: Colors.black.withOpacity(.1),
                          child: Container(
                            padding: const EdgeInsets.all(1).r,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.05),
                              borderRadius: BorderRadius.circular(8).r,
                            ),
                            child: Icon(Icons.arrow_drop_down, size: 20.w),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
