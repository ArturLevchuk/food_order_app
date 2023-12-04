import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_order_app/modules/home/pages/ProductPage/vm/order_preparation_controller.dart';
import '../../../../../models/product.dart';
import '../../../../../widgets/rounded_tap_button.dart';

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
  late final OrderPreparationController orderPreparationController =
      context.read<OrderPreparationController>();
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
                      orderPreparationController
                          .updateSize(size: {sizeName: sizes[sizeName]});
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
