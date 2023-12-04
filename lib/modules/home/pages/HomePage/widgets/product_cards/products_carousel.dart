import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../ProductPage/product_screen.dart';
import '../../../../../../models/product.dart';
import '../../../../../../widgets/rounded_tap_button.dart';
import '../../../../vm/products_viev_model/products_controller.dart';
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
      PageController(viewportFraction: .72);

  late final ProductsController _productsController;

  @override
  void didChangeDependencies() {
    _productsController = Modular.get<ProductsController>();
    if (_productsController.state.status == ProductsStateLoad.init) {
      _productsController.fetchAndSetProducts();
    }
    super.didChangeDependencies();
  }

  int currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RPadding(
          padding: const EdgeInsets.only(
            left: 16,
            top: 24,
            bottom: 24,
          ),
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: categoriesList.keys
                    .map(
                      (tabItemCategory) => RPadding(
                        padding: const EdgeInsets.only(right: 10),
                        child: RoundedTabButton(
                          isActive: currentCategory == tabItemCategory,
                          text: categoriesList[tabItemCategory]!,
                          onTap: () {
                            setState(() {
                              currentCategory = tabItemCategory;
                              currentPage = 0;
                            });
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
          child: StreamBuilder<ProductsState>(
            stream: _productsController.stream,
            builder: (context, state) {
              final List<Product> productsByCategory =
                  _productsController.state.productsByType(currentCategory);
              return _FadeThroughTransitionSwitcher(
                child: PageView.builder(
                  key: ValueKey(currentCategory),
                  controller: _pageController,
                  clipBehavior: Clip.none,
                  itemCount: productsByCategory.length,
                  itemBuilder: (context, index) => AnimatedTranslate(
                    position: currentPage == 0 && (index == 0 || index == 1)
                        ? Offset(-45.w, 0)
                        : Offset.zero,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutExpo,
                    child: FittedBox(
                        alignment: Alignment.topCenter,
                        fit: BoxFit.none,
                        child: ProductCard(
                          product: productsByCategory[index],
                          isExpanded: currentPage == index,
                          buttonTap: (count) {
                            // productCount = count;
                            // openAction();
                            Modular.to.pushNamed("./product/", arguments: {
                              "amount": count,
                              "product": productsByCategory[index],
                            });
                          },
                        )
                        // ProductCardAnimated(
                        //   product: productsByCategory[index],
                        //   isCurrentCard: currentPage == index,
                        // ),
                        ),
                  ),
                  allowImplicitScrolling: false,
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                ),
              );
            },
          ),
        ),
        SizedBox(height: 15.w),
      ],
    );
  }
}

// class ProductCardAnimated extends StatefulWidget {
//   const ProductCardAnimated({
//     super.key,
//     required this.product,
//     required this.isCurrentCard,
//   });

//   final Product product;
//   final bool isCurrentCard;

//   @override
//   State<ProductCardAnimated> createState() => _ProductCardAnimatedState();
// }

// class _ProductCardAnimatedState extends State<ProductCardAnimated> {
//   int productCount = 1;

//   @override
//   Widget build(BuildContext context) {
//     return OpenContainer(
//       tappable: false,
//       useRootNavigator: true,
//       closedColor: Colors.white,
//       routeSettings: RouteSettings(arguments: productCount),
//       closedShape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(16).r),
//       closedElevation: 5,
//       closedBuilder: (context, openAction) {
//         return ProductCard(
//           product: widget.product,
//           isExpanded: widget.isCurrentCard,
//           buttonTap: (count) {
//             productCount = count;
//             openAction();
//           },
//         );
//       },
//       openShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
//       openBuilder: (context, action) {
//         return ProductScreen(
//           product: widget.product,
//         );
//       },
//     );
//   }
// }

class AnimatedTranslate extends StatefulWidget {
  const AnimatedTranslate({
    super.key,
    required this.child,
    required this.position,
    required this.duration,
    this.curve = Curves.linear,
  });
  final Widget child;
  final Offset position;
  final Duration duration;
  final Curve curve;

  @override
  State<AnimatedTranslate> createState() => _TranslateAnimationState();
}

class _TranslateAnimationState extends State<AnimatedTranslate> {
  late final Offset initPosition = widget.position;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: initPosition, end: widget.position),
      curve: widget.curve,
      builder: (context, value, child) => Transform.translate(
        offset: value,
        child: child,
      ),
      duration: widget.duration,
      child: widget.child,
    );
  }
}

class _FadeThroughTransitionSwitcher extends StatelessWidget {
  const _FadeThroughTransitionSwitcher({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      child: child,
      transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
        return FadeTransition(
          opacity: primaryAnimation,
          child: child,
        );
        // return FadeThroughTransition(
        //   animation: primaryAnimation,
        //   secondaryAnimation: secondaryAnimation,
        //   child: child,
        // );
      },
    );
  }
}
