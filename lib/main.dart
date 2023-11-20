import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social/router.dart';
import 'package:minimal_social/theme/light_mode.dart';
import 'package:minimal_social/theme/dark_mode.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
