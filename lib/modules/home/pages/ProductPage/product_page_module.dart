import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_order_app/modules/home/pages/ProductPage/product_screen.dart';

import 'vm/order_preparation_controller.dart';

class ProductScreenModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(OrderPreparationController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => ProductScreen(
        amount: (r.args.data as Map)['amount'],
        product: (r.args.data as Map)['product'],
      ),
      // transition: TransitionType.fadeIn
    );
  }
}
