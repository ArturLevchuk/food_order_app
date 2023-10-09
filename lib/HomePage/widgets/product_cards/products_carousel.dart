
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../ProductsBloc/products_bloc.dart';
import '../../../models/product.dart';
import '../../../widgets/rounded_tap_button.dart';
import 'product_card.dart';

Map<ProductType, String> categoriesList = {
  ProductType.pizza: "Піцци",
  ProductType.salads: "Салати",
  ProductType.soup: "Супи",
  ProductType.drink: "Напої",
};

class ProductsCarousel extends StatefulWidget {
  const ProductsCarousel({super.key});

  @override
  State<ProductsCarousel> createState() => _ProductsCarouselState();
}

class _ProductsCarouselState extends State<ProductsCarousel>
    with SingleTickerProviderStateMixin {
  late ProductType currentCategory = categoriesList.keys.first;
  late final PageController _pageController =
      PageController(viewportFraction: .65.w);
  late AnimationController fadeAnimationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 500))
    ..value = 1;

  int currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RPadding(
          padding: const EdgeInsets.only(left: 16, top: 24, bottom: 24),
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: categoriesList.keys
                    .map(
                      (tabItemCategory) => RPadding(
                        padding: const EdgeInsets.only(right: 3),
                        child: RoundedTabButton(
                          isActive: currentCategory == tabItemCategory,
                          text: categoriesList[tabItemCategory]!,
                          onTap: () {
                            setState(() {
                              currentCategory = tabItemCategory;
                            });
                            _pageController.jumpTo(0);
                            fadeAnimationController.reset();
                            fadeAnimationController.forward();
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
        AspectRatio(
          aspectRatio: 1,
          child: BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              final List<Product> productsByCategory = state.list
                  .where((element) => element.productType == currentCategory)
                  .toList();
              return FadeTransition(
                opacity: fadeAnimationController,
                child: PageView.builder(
                  controller: _pageController,
                  clipBehavior: Clip.none,
                  itemCount: productsByCategory.length,
                  itemBuilder: (context, index) => AnimatedContainer(
                    padding: EdgeInsets.only(
                      right: currentPage == 0 && index == 0
                          ? 95.w
                          : currentPage == 0 && index == 1
                              ? 90.w
                              : 0,
                    ),
                    duration: const Duration(milliseconds: 100),
                    child: FittedBox(
                      alignment: Alignment.topCenter,
                      fit: BoxFit.none,
                      child: ProductCard(
                        product: productsByCategory[index],
                        isExpanded: currentPage == index,
                      ),
                    ),
                  ),
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                ),
              );
            },
          ),
        )
      ],
    );
  }
}