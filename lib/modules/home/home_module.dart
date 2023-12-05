import 'package:flutter_modular/flutter_modular.dart';
import '../../transitions.dart';
import '/modules/home/pages/HomePage/home_page.dart';
import '/modules/home/pages/favorite_page.dart';
import '/modules/home/pages/main_home_page.dart';
import '/modules/home/vm/cart_viev_model/cart_controller.dart';
import '/repositories/cart_repository.dart';
import '/repositories/products_repository.dart';

import 'pages/CartPage/cart_page.dart';
import 'pages/ProductPage/product_page_module.dart';
import 'vm/products_viev_model/products_controller.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.add<ProductsApi>(LocalProductsApi.new);
    i.addSingleton(ProductsController.new);
    i.add<CartApi>(LocalCartApi.new);
    i.addSingleton(CartController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => const MainHomePage(),
      children: [
        ChildRoute(
          FavoritePage.routeName,
          child: (context) => TransitionCover(
              transitionCoverSettings: r.args.data,
              child: const FavoritePage()),
          transition: TransitionType.noTransition,
        ),
        ChildRoute(
          HomePage.routeName,
          child: (context) => TransitionCover(
              transitionCoverSettings: r.args.data, child: const HomePage()),
          transition: TransitionType.noTransition,
        ),
        ChildRoute(
          CartPage.routeName,
          child: (context) => TransitionCover(
              transitionCoverSettings: r.args.data, child: const CartPage()),
          transition: TransitionType.noTransition,
        ),
      ],
      transition: TransitionType.noTransition,
    );
    r.module(
      "/product",
      module: ProductScreenModule(),
    );
  }
}
