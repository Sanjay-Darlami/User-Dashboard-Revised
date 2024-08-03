import 'package:demo_revised_project/app_init.dart';
import 'package:demo_revised_project/pages/home/homepage.dart';
import 'package:demo_revised_project/utils/color_util.dart';
import 'package:demo_revised_project/utils/style_util.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await AppInit.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Project Revised',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: StyleUtil.style16DarkBlueBold,
        ),
        cardTheme: const CardTheme(
          surfaceTintColor: ColorUtil.colorWhite,
          shadowColor: ColorUtil.colorGrey,
          color: ColorUtil.colorWhite,
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
          },
        ),
      ),
      home: const HomePage(),
    );
  }
}
