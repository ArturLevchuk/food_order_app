import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

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
      builder: (context, _) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Food order app',
        theme: _buildTheme(Brightness.light),
        routerConfig: Modular.routerConfig,
      ),
    );
  }
}