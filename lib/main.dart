import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_order_app/CartPage/bloc/cart_bloc.dart';
import 'package:food_order_app/HomePage/home_page.dart';
import 'package:food_order_app/ProductsBloc/products_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'CartPage/cart_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final appNavigatorKey = GlobalKey<NavigatorState>();

  ThemeData _buildTheme(Brightness brightness) {
    var baseTheme = ThemeData(
        brightness: brightness, primaryColor: const Color(0xFFE52D2D));

    return baseTheme.copyWith(
      textTheme: GoogleFonts.montserratTextTheme(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, _) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProductsBloc()..add(FetchAndLoadProducts()),
          ),
          BlocProvider(
            create: (context) => CartBloc(
              productsBloc: context.read<ProductsBloc>(),
            ),
          ),
        ],
        child: MaterialApp(
          navigatorKey: appNavigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Food order app',
          theme: _buildTheme(Brightness.light),
          routes: {
            '/': (context) => const InitPage(),
            LoadingPage.routeName: (context) => const LoadingPage(),
            MainPage.routeName: (context) => const MainPage(),
          },
        ),
      ),
    );
  }
}

class InitPage extends StatelessWidget {
  const InitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        if (state.status == ProductStateLoad.loaded) {
          return const MainPage();
        } else {
          return const LoadingPage();
        }
      },
    );
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  static const routeName = '/LoadingPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

enum MainPages { homePage, favoritePage, cartPage }

class MainPage extends StatefulWidget {
  const MainPage({super.key, this.initialPageRoute = HomePage.routeName});
  static const routeName = '/MainPage';
  final String initialPageRoute;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // final _navigatorKey = GlobalKey<NavigatorState>();
  late MainPages currentPage;
  MainPages previousPage = MainPages.homePage;

  @override
  void initState() {
    super.initState();
    switch (widget.initialPageRoute) {
      case HomePage.routeName:
        {
          currentPage = MainPages.homePage;
          break;
        }
      case CartScreen.routeName:
        {
          currentPage = MainPages.cartPage;
        }
    }
  }

  Widget get page {
    switch (currentPage) {
      case MainPages.homePage:
        {
          return const HomePage();
        }
      case MainPages.favoritePage:
        {
          return const CartScreen();
        }
      case MainPages.cartPage:
        {
          return const CartScreen();
        }
      default:
        {
          return const HomePage();
        }
    }
  }

  bool get leftForwardAnimation {
    if (previousPage == MainPages.cartPage) {
      return true;
    }
    if (previousPage == MainPages.homePage &&
        currentPage == MainPages.favoritePage) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AxisAnimation(page: page, reverse: leftForwardAnimation),
      // Navigator(
      //   key: _navigatorKey,
      //   initialRoute: widget.initialPageRoute,
      //   onGenerateRoute: (settings) {
      //     late Widget page;
      //     Offset moveTo = const Offset(1, 0);
      //     print(settings.name);
      //     switch (settings.name) {
      //       case "/":
      //         {
      //           return null;
      //         }
      //       case HomePage.routeName:
      //         {
      //           page = const HomePage();
      //           if (currentPage == MainPages.cartPage) {
      //             moveTo = const Offset(-1, 0);
      //           }
      //           break;
      //         }
      //       case CartScreen.routeName:
      //         {
      //           page = const CartScreen();
      //           break;
      //         }
      //     }
      //     return slideAnimationRouteBuilder(page, moveTo);
      //   },
      // ),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                if (currentPage == MainPages.favoritePage) return;
                // _navigatorKey.currentState?.pushNamed(CartScreen.routeName);
                setState(() {
                  previousPage = currentPage;
                  currentPage = MainPages.favoritePage;
                });
              },
              icon: SvgPicture.asset(
                "assets/icons/favorite.svg",
                width: iconSize.w,
                height: iconSize.w,
                color: currentPage == MainPages.favoritePage
                    ? Theme.of(context).primaryColor
                    : null,
              ),
            ),
            IconButton(
              onPressed: () {
                if (currentPage == MainPages.homePage) return;
                // _navigatorKey.currentState?.pushNamed(HomePage.routeName);
                setState(() {
                  previousPage = currentPage;
                  currentPage = MainPages.homePage;
                });
              },
              icon: SvgPicture.asset(
                "assets/icons/home.svg",
                width: iconSize.w,
                height: iconSize.w,
                color: currentPage == MainPages.homePage
                    ? Theme.of(context).primaryColor
                    : null,
              ),
            ),
            IconButton(
              onPressed: () {
                if (currentPage == MainPages.cartPage) return;
                // _navigatorKey.currentState?.pushNamed(CartScreen.routeName);
                setState(() {
                  previousPage = currentPage;
                  currentPage = MainPages.cartPage;
                });
              },
              icon: SvgPicture.asset(
                "assets/icons/cart.svg",
                width: iconSize.w,
                height: iconSize.w,
                color: currentPage == MainPages.cartPage
                    ? Theme.of(context).primaryColor
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

PageRouteBuilder slideAnimationRouteBuilder(Widget page, Offset begin) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) {
      return page;
    },
    transitionsBuilder: (_, animation, __, child) {
      const Offset end = Offset.zero;
      return SlideTransition(
        position: Tween<Offset>(begin: begin, end: end).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      );
    },
  );
}

class AxisAnimation extends StatelessWidget {
  const AxisAnimation({super.key, required this.page, required this.reverse});

  final Widget page;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      duration: const Duration(milliseconds: 400),
      reverse: reverse,
      child: page,
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

// class FavoriteScreen extends StatelessWidget {
//   const FavoriteScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: 5,
//         padding: EdgeInsets.all(20).r,
//         itemBuilder: (context, index) {
//           return Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(20).r,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: const [
//                 BoxShadow(
//                   color: Color(0x28000000),
//                   blurRadius: 8,
//                   offset: Offset(0, 2),
//                 ),
//               ],
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Row(
//               children: [

//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }