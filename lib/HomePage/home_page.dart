import 'package:flutter/material.dart';
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

