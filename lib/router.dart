import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minimal_social/auth/view/login_page.dart';
import 'package:minimal_social/auth/view/register_page.dart';
import 'package:minimal_social/home/view/home_page.dart';
import 'package:minimal_social/profile/view/profile_page.dart';
import 'package:minimal_social/users/view/users_page.dart';

class MINRouter {
  late final User? loginInfo;

  MINRouter() : loginInfo = FirebaseAuth.instance.currentUser;
  static GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return HomePage();
        },
        routes: [
          GoRoute(
            path: 'profile',
            builder: (BuildContext context, GoRouterState state) {
              return ProfilePage();
            },
          ),
          GoRoute(
            path: 'users',
            builder: (BuildContext context, GoRouterState state) {
              return const UsersPage();
            },
          ),
        ],
      ),
      GoRoute(
        path: '/register',
        builder: (BuildContext context, GoRouterState state) {
          return const RegisterPage();
        },
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
    ],
    refreshListenable:
        GoRouterRefreshStream(FirebaseAuth.instance.authStateChanges()),
    redirect: (BuildContext context, GoRouterState state) {
      final loggingIn = state.matchedLocation == '/register' ||
          state.matchedLocation == '/login';
      if (FirebaseAuth.instance.currentUser == null &&
          state.matchedLocation != '/register') {
        return '/login';
      }
      if (FirebaseAuth.instance.currentUser != null && loggingIn) {
        return '/';
      }
      return null;
    },
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
