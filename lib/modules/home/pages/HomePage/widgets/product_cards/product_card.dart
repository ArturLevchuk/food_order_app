import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_order_app/models/product.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../widgets/count_button.dart';
import '../../../../../../widgets/like_animated_icon.dart';
import '../../../../../../widgets/rounded_button.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.isExpanded,
    required this.product,
    required this.buttonTap,
  });

  final Product product;
  final bool isExpanded;
  final Function(int count) buttonTap;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int count = 1;
  Product get product => widget.product;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: product.id,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 256.w,
          padding: const EdgeInsets.all(16).w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16).r,
            boxShadow: const [
              BoxShadow(
                color: Color(0x28000000),
                blurRadius: 8,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: AnimatedSize(
            alignment: Alignment.topCenter,
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12).r,
                  child: SizedBox(
                    // height: MediaQuery.of(context).size.height * 0.2,
                    height: 140.w,
                    width: double.infinity,
                    child: Image.asset(
                      product.imgSrc,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 19),
                Text(
                  product.name,
                  style: GoogleFonts.montserrat(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.w),
                Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 14.sp,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 4,
                ),
                SizedBox(height: 10.w),
                Row(
                  children: [
                    Text(
                      "${product.sizes.values.first} грн.",
                      style: GoogleFonts.montserrat(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    ...[
                      CountButton(
                        icon: Icons.remove,
                        tap: () {
                          if (count == 1) return;
                          setState(() {
                            count--;
                          });
                        },
                      ),
                      SizedBox(
                        width: 40.w,
                        child: Text(
                          textAlign: TextAlign.center,
                          "$count",
                          style: GoogleFonts.montserrat(
                            fontSize: 16.sp,
                          ),
                          // height: 140,
                        ),
                      ),
                      CountButton(
                        icon: Icons.add,
                        tap: () {
                          setState(() {
                            count++;
                          });
                        },
                      ),
                    ]
                  ],
                ),
                if (widget.isExpanded)
                  Padding(
                    padding: const EdgeInsets.only(top: 6).r,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: RoundedButton(
                            buttonName: "Додати до замовлення",
                            fontSize: 13,
                            onTap: () {
                              widget.buttonTap(count);
                            },
                            // () {
                            //   MyApp.appNavigatorKey.currentState?.push(
                            //     MaterialPageRoute(
                            //       builder: (context) =>
                            //           ProductScreen(product: product),
                            //       settings: RouteSettings(arguments: count),
                            //     ),
                            //   );
                            // },
                          ),
                        ),
                        const RPadding(
                          padding: EdgeInsets.only(left: 10),
                          child: LikeButton(size: 30),
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LikeButton extends StatefulWidget {
  const LikeButton({super.key, required this.size});
  final double size;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton>
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
    return InkWell(
      onTap: () {
        if (_animationController.value == 0) {
          _animationController.forward();
        } else if (_animationController.value == 1) {
          _animationController.reverse();
        }
      },
      child: LikeAnimatedIcon(
        size: widget.size,
        animationController: _animationController,
      ),
    );
  }
}
