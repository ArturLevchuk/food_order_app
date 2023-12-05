import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  static const routeName = "/favoritePage";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Favorite Page"),
      ),
    );
  }
}
