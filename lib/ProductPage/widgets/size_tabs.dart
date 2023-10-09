import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/product.dart';
import '../../widgets/rounded_tap_button.dart';
import '../bloc/order_preparation_bloc.dart';

class SizeTabs extends StatefulWidget {
  const SizeTabs({
    super.key,
    required this.product,
  });
  final Product product;

  @override
  State<SizeTabs> createState() => _SizeTabsState();
}

class _SizeTabsState extends State<SizeTabs> {
  Product get product => widget.product;
  late String pizzaDiameter = product.sizes.first.keys.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Text(
            "Оберіть розмір порції:",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        RPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            runSpacing: 10.w,
            spacing: 10.w,
            children: [
              ...List.generate(
                product.sizes.length,
                (index) {
                  final String size = product.sizes[index].keys.first;
                  return RoundedTabButton(
                    text: product.productType.getProductUnit(size),
                    isActive: pizzaDiameter == size,
                    fontWeight: FontWeight.w600,
                    onTap: () {
                      setState(() {
                        pizzaDiameter = size;
                      });
                      context.read<OrderPreparationBloc>().add(
                            UpdatePrice(
                              price: widget.product.sizes
                                  .firstWhere((element) =>
                                      element.keys.contains(pizzaDiameter))
                                  .values
                                  .first,
                            ),
                          );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
