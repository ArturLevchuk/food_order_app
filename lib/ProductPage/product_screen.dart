import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_order_app/main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../CartPage/cart_screen.dart';
import '/models/product.dart';
import 'bloc/order_preparation_bloc.dart';
import 'widgets/additives_list.dart';
import 'widgets/image_card.dart';
import 'widgets/size_tabs.dart';

import '/widgets/rounded_button.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.product});

  final Product product;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Product get product => widget.product;

  @override
  Widget build(BuildContext context) {
    final initPrice = double.parse(product.sizes.values.first.toString());
    return BlocProvider(
      create: (context) => OrderPreparationBloc(initPrice),
      lazy: false,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageCard(
                  height: 300.h,
                  imgSrc: widget.product.imgSrc,
                ),
                SizedBox(height: 32.h),
                RPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    widget.product.name,
                    style: GoogleFonts.montserrat(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                RPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    widget.product.description,
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                SizeTabs(product: widget.product),
                if (widget.product.additives.isNotEmpty)
                  RPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AdditivesList(product: widget.product),
                  ),
                SizedBox(height: 16.h),
                RPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        "Ціна:",
                        style: GoogleFonts.montserrat(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      BlocBuilder<OrderPreparationBloc, OrderPreparationState>(
                        builder: (context, state) {
                          return Text(
                            "${state.getPrice} грн.",
                            style: GoogleFonts.montserrat(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                RPadding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: RoundedButton(
                      buttonName: "Перейти до оформлення",
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const MainPage(
                                  initialPageRoute: CartScreen.routeName),
                            ),
                            (route) => true);
                      },
                    ),
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
