import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_social/pages/login_page.dart';
import 'package:simple_social/pages/register_page.dart';

class MINRouter {
  static GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return LoginPage();
        },
      ),
      GoRoute(
        path: '/register',
        builder: (BuildContext context, GoRouterState state) {
          return RegisterPage();
        },
      ),
    ],
  );
}
