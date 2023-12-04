import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:food_order_app/transitions.dart';
import 'widgets/product_cards/products_carousel.dart';
import 'widgets/search_textfield.dart';
import 'widgets/text_banner.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = '/homePage';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextBanner(),
              SearchTextField(),
              ProductsCarousel(),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePageWithTrasition extends StatefulWidget {
  const HomePageWithTrasition({super.key, this.transition});

  final bool? transition;

  @override
  State<HomePageWithTrasition> createState() => _HomePageWithTrasitionState();
}

class _HomePageWithTrasitionState extends State<HomePageWithTrasition> {
  Widget child = const SizedBox();

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      setState(() {
        child = const HomePage();
      });
    });
    if (widget.transition == null) {
      return PageTransitionSwitcher(
        duration: const Duration(milliseconds: 500),
        child: child,
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return fastAccesTransition(
            child,
            primaryAnimation,
            secondaryAnimation,
            FastAccesTransition.fadeThrough,
          );
        },
      );
    } else {
      return PageTransitionSwitcher(
        duration: const Duration(milliseconds: 500),
        reverse: widget.transition!,
        child: child,
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return fastAccesTransition(
            child,
            primaryAnimation,
            secondaryAnimation,
            FastAccesTransition.xAxis,
          );
        },
      );
    }
  }
}
