import 'package:flutter/material.dart';
import 'package:simple_social/pages/login_page.dart';
import 'package:simple_social/router.dart';
import 'package:simple_social/theme/light_mode.dart';
import 'package:simple_social/theme/dark_mode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: MINRouter.router,
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
