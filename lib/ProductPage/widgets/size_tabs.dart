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
  Map<String, dynamic> get sizes => widget.product.sizes;
  late String currentSize = sizes.keys.first;
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
                sizes.length,
                (index) {
                  final String sizeName = sizes.keys.elementAt(index);
                  return RoundedTabButton(
                    text: widget.product.productType.getProductUnit(sizeName),
                    isActive: currentSize == sizeName,
                    fontWeight: FontWeight.w600,
                    onTap: () {
                      setState(() {
                        currentSize = sizeName;
                      });
                      final double price =
                          double.parse(sizes[sizeName].toString());
                      context.read<OrderPreparationBloc>().add(
                            UpdatePrice(price: price),
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
