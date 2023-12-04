import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'modules/main_module.dart';
import 'modules/main_page.dart';

void main() {
  runApp(
    ModularApp(
      module: MainModule(),
      child: const MainPage(),
    ),
  );
}
