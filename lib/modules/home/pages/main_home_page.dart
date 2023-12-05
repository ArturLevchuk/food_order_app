import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_order_app/modules/home/pages/favorite_page.dart';

import '../../../transitions.dart';
import 'CartPage/cart_page.dart';
import 'HomePage/home_page.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({super.key});

  void changeInternalPage(String pageRoute,
      [TransitionCoverSettings? transitionCoverSettings]) {
    Modular.to.navigate(
      ".$pageRoute",
      arguments: transitionCoverSettings,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (Modular.to.path == "/home/") {
      changeInternalPage(HomePage.routeName);
    }
    return Scaffold(
      body: const RouterOutlet(),
      bottomNavigationBar: bottomNavBar(context: context),
    );
  }

  DecoratedBox bottomNavBar(
      {required BuildContext context, double iconSize = 32}) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 4,
            offset: Offset(0, -4),
          )
        ],
      ),
      child: BottomAppBar(
        color: Colors.white,
        shadowColor: null,
        child: NavigationListener(builder: (context, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  if (Modular.to.path.endsWith(FavoritePage.routeName)) return;
                  changeInternalPage(
                    FavoritePage.routeName,
                    const TransitionCoverSettings(
                      transition: FastAccesTransition.xAxis,
                      reversed: true,
                    ),
                  );
                },
                icon: SvgPicture.asset(
                  "assets/icons/favorite.svg",
                  width: iconSize.w,
                  height: iconSize.w,
                  color: Modular.to.path.endsWith(FavoritePage.routeName)
                      ? Theme.of(context).primaryColor
                      : null,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (Modular.to.path.endsWith(HomePage.routeName)) return;
                  final bool rightToLeft =
                      Modular.to.path.endsWith(CartPage.routeName);
                  changeInternalPage(
                    HomePage.routeName,
                    TransitionCoverSettings(
                      transition: FastAccesTransition.xAxis,
                      reversed: rightToLeft,
                    ),
                  );
                },
                icon: SvgPicture.asset(
                  "assets/icons/home.svg",
                  width: iconSize.w,
                  height: iconSize.w,
                  color: (Modular.to.path.endsWith(HomePage.routeName))
                      ? Theme.of(context).primaryColor
                      : null,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (Modular.to.path.endsWith(CartPage.routeName)) return;
                  changeInternalPage(
                    CartPage.routeName,
                    const TransitionCoverSettings(
                        transition: FastAccesTransition.xAxis),
                  );
                },
                icon: SvgPicture.asset(
                  "assets/icons/cart.svg",
                  width: iconSize.w,
                  height: iconSize.w,
                  color: (Modular.to.path.endsWith(CartPage.routeName))
                      ? Theme.of(context).primaryColor
                      : null,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
