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


class FavoritePageWithTransition extends StatefulWidget {
  const FavoritePageWithTransition({super.key});

  @override
  State<FavoritePageWithTransition> createState() => _FavoritePageWithTransitionState();
}

class _FavoritePageWithTransitionState extends State<FavoritePageWithTransition> {
Widget child = const SizedBox();

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      setState(() {
        child = const FavoritePage();
      });
    });

    return PageTransitionSwitcher(
      duration: const Duration(milliseconds: 500),
      child: child,
      transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
        return SharedAxisTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          child: child,
        );
      },
    );
  }
}