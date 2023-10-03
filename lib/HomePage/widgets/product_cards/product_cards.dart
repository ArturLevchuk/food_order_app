import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_order_app/models/product.dart';
import 'product_card.dart';

class ProductCardCarousel extends StatefulWidget {
  const ProductCardCarousel({
    super.key,
  });

  @override
  State<ProductCardCarousel> createState() => _ProductCardCarouselState();
}

class _ProductCardCarouselState extends State<ProductCardCarousel>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController =
      PageController(viewportFraction: .65.w);

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: PageView.builder(
        controller: _pageController,
        clipBehavior: Clip.none,
        itemCount: allProducts.length,
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
              product: allProducts[index],
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
  }
}
