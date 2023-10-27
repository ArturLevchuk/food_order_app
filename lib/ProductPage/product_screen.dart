import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_order_app/models/cart_item.dart';
import 'package:food_order_app/repositories/cart_repository.dart';
import 'package:google_fonts/google_fonts.dart';

import '../CartPage/bloc/cart_bloc.dart';
import '../CartPage/cart_screen.dart';
import '../main.dart';
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
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final int count = ModalRoute.of(context)!.settings.arguments as int;
    final initSize = Map.fromEntries([product.sizes.entries.first]);
    return BlocProvider(
      create: (context) => OrderPreparationBloc(initSize, count),
      lazy: false,
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
                          BlocBuilder<OrderPreparationBloc,
                              OrderPreparationState>(
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: BlocBuilder<OrderPreparationBloc,
                            OrderPreparationState>(
                          builder: (context, state) {
                            return RoundedButton(
                              buttonName: "Перейти до оформлення",
                              onTap: () async {
                                try {
                                  setState(() {
                                    loading = true;
                                  });
                                  await Future.delayed(Duration(seconds: 1));
                                  final additives = state.additives;
                                  final size = state.size;
                                  final CartItem cartItem = CartItem(
                                    cartId: DateTime.now()
                                        .microsecondsSinceEpoch
                                        .toString(),
                                    count: count,
                                    product: product,
                                    additives: additives,
                                    size: size,
                                  );
                                  // await CartRepository.addToCart(cartItem);
                                  CartRepository(cartApi: FirebaseCartApi())
                                      .addToCart(cartItem);
                                  if (context
                                          .read<CartBloc>()
                                          .state
                                          .cartStateLoad !=
                                      CartStateLoad.init) {
                                    context.read<CartBloc>().add(
                                          AddToCart(cartItem: cartItem),
                                        );
                                  }
                                  setState(() {
                                    loading = false;
                                  });
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => const MainPage(
                                            initialPageRoute:
                                                CartScreen.routeName),
                                      ),
                                      (route) => true);
                                } catch (err) {
                                  print(err.toString());
                                }
                              },
                            );
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
