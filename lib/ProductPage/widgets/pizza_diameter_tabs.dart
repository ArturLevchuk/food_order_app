import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/product.dart';
import '../../widgets/rounded_tap_button.dart';
import '../bloc/order_preparation_bloc.dart';

class PizzaDiameterTabs extends StatefulWidget {
  const PizzaDiameterTabs({
    super.key,
    required this.pizzaProduct,
  });
  final PizzaProduct pizzaProduct;

  @override
  State<PizzaDiameterTabs> createState() => _PizzaDiameterTabsState();
}

class _PizzaDiameterTabsState extends State<PizzaDiameterTabs> {
  PizzaProduct get pizzaProduct => widget.pizzaProduct;
  late String pizzaDiameter = pizzaProduct.sizes.first.keys.first;

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
            "Оберіть діаметр піци",
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
                pizzaProduct.sizes.length,
                (index) {
                  final String diameter = pizzaProduct.sizes[index].keys.first;
                  return RoundedTabButton(
                    text: "Ø$diameter",
                    isActive: pizzaDiameter == diameter,
                    fontWeight: FontWeight.w600,
                    onTap: () {
                      setState(() {
                        pizzaDiameter = diameter;
                      });
                      context.read<OrderPreparationBloc>().add(
                            UpdatePrice(
                              price: widget.pizzaProduct.sizes
                                  .firstWhere((element) =>
                                      element.keys.first == pizzaDiameter)
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

class PizzaDiameterCard extends StatelessWidget {
  const PizzaDiameterCard({
    super.key,
    required this.diameter,
    required this.isActive,
    required this.onTap,
  });

  final String diameter;
  final bool isActive;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context).primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 1.5,
            color: Theme.of(context).primaryColor,
          ),
        ),
        duration: const Duration(milliseconds: 250),
        child: Text(
          "Ø$diameter",
          style: TextStyle(
            color: isActive ? Colors.white : Theme.of(context).primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
