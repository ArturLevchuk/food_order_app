import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_order_app/modules/home/vm/cart_viev_model/cart_controller.dart';
import 'package:food_order_app/transitions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/cart_card.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  static const routeName = '/cartPage';

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void didChangeDependencies() {
    final cartController = context.read<CartController>();
    if (cartController.state.cartStateLoad == CartStateLoad.init) {
      cartController.fetchAndSetCart();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final CartController cartController = context.read<CartController>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Кошик",
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: StreamBuilder<CartState>(
        stream: cartController.stream,
        builder: (context, asyncS) {
          final CartState state = cartController.state;
          return state.cartStateLoad == CartStateLoad.loaded
              ? ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: state.list.length,
                  itemBuilder: (context, index) {
                    return RPadding(
                      padding:
                          EdgeInsets.only(bottom: 20, top: index == 0 ? 10 : 0),
                      child: SlideableCartCard(
                          key: ValueKey(state.list[index].cartId),
                          cartItem: state.list[index]),
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor),
                );
        },
      ),
    );
  }
}

class CartPageWithTrasition extends StatefulWidget {
  const CartPageWithTrasition({super.key, this.transition});

  final bool? transition;

  @override
  State<CartPageWithTrasition> createState() => _CartPageWithTrasitionState();
}

class _CartPageWithTrasitionState extends State<CartPageWithTrasition> {
  Widget child = const SizedBox();

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      setState(() {
        child = const CartPage();
      });
    });
    if (widget.transition == null) {
      return PageTransitionSwitcher(
        duration: const Duration(milliseconds: 500),
        child: child,
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return fastAccesTransition(child, primaryAnimation,
              secondaryAnimation, FastAccesTransition.fadeThrough);
        },
      );
    } else {
      return PageTransitionSwitcher(
        duration: const Duration(milliseconds: 500),
        child: child,
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return fastAccesTransition(child, primaryAnimation,
              secondaryAnimation, FastAccesTransition.xAxis);
        },
      );
    }
  }
}
