import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/product.dart';
import '../bloc/order_preparation_bloc.dart';

class AdditivesList extends StatelessWidget {
  const AdditivesList({
    super.key,
    required this.product,
    this.showButtons = true,
  });

  final Product product;
  final bool showButtons;

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
        ...List.generate(product.additives.length, (index) {
          final Map<String, dynamic> currentAdditive = product.additives[index];
          final String nameOfAddetive = currentAdditive.keys.first;
          final String priceOfAddetive =
              currentAdditive.values.first.toString();
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
                if (showButtons)
                  BlocBuilder<OrderPreparationBloc, OrderPreparationState>(
                    builder: (context, state) {
                      return AddAdditiveButton(
                        added: state.additives.contains(currentAdditive),
                        onTap: () async {
                          if (state.additives.contains(currentAdditive)) {
                            context.read<OrderPreparationBloc>().add(
                                  RemoveAdditive(additive: currentAdditive),
                                );
                          } else {
                            context.read<OrderPreparationBloc>().add(
                                  AddAdditive(
                                    additive: currentAdditive,
                                  ),
                                );
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
        child: FittedBox(
          child: Icon(
            added ? Icons.done : Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
