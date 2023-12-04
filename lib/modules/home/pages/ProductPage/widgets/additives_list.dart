import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_order_app/modules/home/pages/ProductPage/vm/order_preparation_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../models/product.dart';
import '../vm/order_preparation_state.dart';

class AdditivesList extends StatefulWidget {
  const AdditivesList({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<AdditivesList> createState() => _AdditivesListState();
}

class _AdditivesListState extends State<AdditivesList> {
  late final OrderPreparationController orderPreparationController =
      context.read<OrderPreparationController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RPadding(
          padding: const EdgeInsets.only(top: 14, bottom: 3),
          child: Text(
            "Добавки:",
            style: GoogleFonts.montserrat(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ...List.generate(widget.product.additives.length, (index) {
          final Map<String, dynamic> currentAdditive = Map.fromEntries(
              [widget.product.additives.entries.elementAt(index)]);
          final String nameOfAddetive = currentAdditive.keys.first;
          final String priceOfAddetive =
              currentAdditive[nameOfAddetive].toString();
          return RPadding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Text(
                  nameOfAddetive,
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Text(
                  "$priceOfAddetive грн.",
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 10.w),
                StreamBuilder<OrderPreparationState>(
                  stream: orderPreparationController.stream,
                  builder: (context, state) {
                    final added = orderPreparationController
                        .state.additives.keys
                        .contains(currentAdditive.keys.first);

                    return AddAdditiveButton(
                      // key: ValueKey(added),
                      added: added,
                      onTap: () async {
                        if (orderPreparationController.state.additives.keys
                            .contains(currentAdditive.keys.first)) {
                          orderPreparationController.removeAdditive(
                              additive: currentAdditive);
                        } else {
                          orderPreparationController.addAdditive(
                              additive: currentAdditive);
                        }
                      },
                    );
                  },
                )
              ],
            ),
          );
        }),
      ],
    );
  }
}

class AddAdditiveButton extends StatelessWidget {
  const AddAdditiveButton({
    super.key,
    required this.added,
    required this.onTap,
  });

  final bool added;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // padding: added ? const EdgeInsets.all(4).r : null,
        padding: const EdgeInsets.all(3).r,
        height: 24.w,
        width: 24.w,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        child: FadeThroughtTransitionSwitcher(
          child: FittedBox(
            key: ValueKey(added),
            child: Icon(
              added ? Icons.done : Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class FadeThroughtTransitionSwitcher extends StatelessWidget {
  const FadeThroughtTransitionSwitcher({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      child: child,
      transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
        return FadeThroughTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          fillColor: Colors.transparent,
          child: child,
        );
        // return SharedAxisTransition(
        //   fillColor: Colors.transparent,
        //   animation: primaryAnimation,
        //   secondaryAnimation: secondaryAnimation,
        //   transitionType: SharedAxisTransitionType.scaled,
        //   child: child,
        // );
      },
    );
  }
}
