import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/category_taps.dart';
import 'widgets/product_cards/product_cards.dart';
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
              RPadding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: CategoryTabs(),
              ),
              ProductCardCarousel(),
            ],
          ),
        ),
      ),
    );
  }
}
