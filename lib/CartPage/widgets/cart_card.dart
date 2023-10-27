import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/cart_item.dart';
import '../../widgets/rounded_dialog.dart';
import '../bloc/cart_bloc.dart';
import 'scroll_motion_ex.dart';

class SlideableCartCard extends StatefulWidget {
  const SlideableCartCard({
    super.key,
    required this.cartItem,
  });

  final CartItem cartItem;

  @override
  State<SlideableCartCard> createState() => _SlideableCartCardState();
}

class _SlideableCartCardState extends State<SlideableCartCard>
    with SingleTickerProviderStateMixin {
  ValueNotifier<bool> sliding = ValueNotifier(false);

  // bool sliding = false;
  late AnimationController controller;
  late Animation<double> opacityAnimation;
  late Animation<double> sizeAnimation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    opacityAnimation = Tween<double>(begin: 1, end: 0).animate(controller);
    sizeAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: controller, curve: Curves.elasticInOut),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacityAnimation,
      child: ScaleTransition(
        scale: sizeAnimation,
        child: Slidable(
          endActionPane: ActionPane(
            extentRatio: 0.3.w,
            motion: ScrollMotionEx(
              callBack: (status) {
                if (status == AnimationStatus.dismissed) {
                  sliding.value = false;
                } else {
                  sliding.value = true;
                }
              },
            ),
            children: [
              Builder(builder: (context) {
                return Expanded(
                  child: Material(
                    color: Colors.red,
                    borderRadius: BorderRadius.horizontal(
                      right: const Radius.circular(16).r,
                    ),
                    child: InkWell(
                      splashColor: Colors.black.withOpacity(.2),
                      borderRadius: BorderRadius.horizontal(
                        right: const Radius.circular(16).r,
                      ),
                      onTap: () async {
                        await showDialog<bool?>(
                          context: context,
                          builder: (context) {
                            return RoundedDialog(
                              children: removeFromCartDialog,
                            );
                          },
                        ).then((res) {
                          if (res == null || res == false) {
                            Slidable.of(context)?.close();
                            return;
                          } else {
                            controller.forward().then((_) {
                              context.read<CartBloc>().add(
                                    RemoveFromCart(
                                      cartId: widget.cartItem.cartId,
                                    ),
                                  );
                            });
                          }
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          SizedBox(height: 3.w),
                          Text(
                            "Видалити",
                            style: GoogleFonts.montserrat(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })
            ],
          ),
          child: ValueListenableBuilder(
              valueListenable: sliding,
              builder: (context, sliding, _) {
                return CartCard(
                  cartItem: widget.cartItem,
                  sliding: sliding,
                );
              }),
        ),
      ),
    );
  }

  List<Widget> get removeFromCartDialog => [
        Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
              text: "Ви справді хочете прибрати ",
              style: GoogleFonts.montserrat(
                fontSize: 16.sp,
              ),
              children: [
                TextSpan(
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                  text: widget.cartItem.product.name,
                ),
                const TextSpan(
                  text: " з кошика?",
                )
              ]),
        ),
        SizedBox(height: 5.w),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              style: ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                overlayColor: MaterialStatePropertyAll(
                  Colors.green.withOpacity(.1),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              label: const Text(
                "Так",
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
              ),
              icon: const Icon(
                Icons.check,
                color: Colors.green,
              ),
            ),
            TextButton.icon(
              style: ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                overlayColor: MaterialStatePropertyAll(
                  Colors.red.withOpacity(.1),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              label: const Text(
                "Ні",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
              ),
              icon: const Icon(
                Icons.close,
                color: Colors.red,
              ),
            ),
          ],
        )
      ];
}


class CartCard extends StatelessWidget {
  const CartCard({
    super.key,
    required this.cartItem,
    this.sliding = false,
  });

  final CartItem cartItem;
  final bool sliding;

  @override
  Widget build(BuildContext context) {
    final String additives = cartItem.additives.keys.isNotEmpty
        ? "${cartItem.additives.keys.reduce((value, element) => "$value, $element")}."
        : "Немає.";
    return AnimatedContainer(
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
        borderRadius: BorderRadius.horizontal(
            left: const Radius.circular(16).r,
            right: sliding ? Radius.zero : const Radius.circular(16).r),
      ),
      duration: const Duration(milliseconds: 200),
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
                      cartItem.product.imgSrc,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text.rich(
                        style: GoogleFonts.montserrat(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        TextSpan(
                          text: cartItem.product.name,
                          children: [
                            TextSpan(
                              style: TextStyle(
                                fontSize: 16.sp,
                              ),
                              text: " x${cartItem.count}",
                            ),
                          ],
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
                          cartItem.product.productType.getProductUnit(
                              cartItem.size.keys.first.toString()),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        "${cartItem.getPrice} грн.",
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
                    "Добавки: $additives",
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                    ),
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
