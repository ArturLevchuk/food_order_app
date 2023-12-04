import 'package:flutter_modular/flutter_modular.dart';

import 'pages/init_load_page.dart';

class InitModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => const LoadingPage(),
    );
  }
}
