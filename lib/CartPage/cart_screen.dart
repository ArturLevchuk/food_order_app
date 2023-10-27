import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_order_app/CartPage/bloc/cart_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/cart_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  static const routeName = '/cart_screen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void didChangeDependencies() {
    if (context.read<CartBloc>().state.cartStateLoad == CartStateLoad.init) {
      context.read<CartBloc>().add(FetchAndSetCart());
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
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
