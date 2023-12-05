import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/modules/home/pages/CartPage/cart_page.dart';
import '/modules/home/pages/ProductPage/vm/order_preparation_controller.dart';
import '/modules/home/vm/cart_viev_model/cart_controller.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../models/cart_item.dart';
import '/models/product.dart';
import 'widgets/additives_list.dart';
import 'widgets/image_card.dart';
import 'widgets/size_tabs.dart';

import '/widgets/rounded_button.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.product, required this.amount});

  final Product product;
  final int amount;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late final OrderPreparationController orderPreparationController;
  Product get product => widget.product;
  bool loading = false;

  @override
  void didChangeDependencies() {
    final initSize = Map.fromEntries([product.sizes.entries.first]);
    orderPreparationController = context.read<OrderPreparationController>()
      ..init(
        count: widget.amount,
        size: initSize,
      );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: product.id,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
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
                    if (widget.product.additives.isNotEmpty) ...[
                      RPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: AdditivesList(product: widget.product),
                      ),
                      SizedBox(height: 16.h),
                    ] else
                      SizedBox(
                        height: 99.h,
                      ),
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
                          StreamBuilder(
                            stream: orderPreparationController.stream,
                            builder: (_, __) {
                              return Text(
                                "${orderPreparationController.state.getPrice} грн.",
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: RoundedButton(
                          buttonName: "Перейти до оформлення",
                          onTap: () async {
                            try {
                              setState(() {
                                loading = true;
                              });

                              final additives =
                                  orderPreparationController.state.additives;
                              final size =
                                  orderPreparationController.state.size;
                              final CartItem cartItem = CartItem(
                                cartId: DateTime.now()
                                    .microsecondsSinceEpoch
                                    .toString(),
                                count: widget.amount,
                                productId: product.id,
                                additives: additives,
                                size: size,
                              );
                              context
                                  .read<CartController>()
                                  .addToCart(cartItem);
                              await Future.delayed(const Duration(seconds: 1));

                              setState(() {
                                loading = false;
                              });
                              Modular.to.navigate("/home${CartPage.routeName}");
                            } catch (err) {
                              setState(() {
                                loading = false;
                              });     
                              print(err.toString());
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (loading)
                Stack(
                  children: [
                    ModalBarrier(
                      dismissible: false,
                      color: Colors.black.withOpacity(.7),
                    ),
                    Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
