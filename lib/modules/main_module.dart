import 'package:flutter_modular/flutter_modular.dart';
import 'package:food_order_app/modules/home/home_module.dart';
import 'package:food_order_app/modules/init/init_module.dart';

class MainModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.module('/', module: InitModule());
    r.module('/home', module: HomeModule());
  }
}
