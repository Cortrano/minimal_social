import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MINDrawer extends StatelessWidget {
  const MINDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          DrawerHeader(
            child: Icon(
              Icons.circle_outlined,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              leading: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: const Text("H O M E"),
              onTap: () {
                Navigator.pop(context);
                context.go('/');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              leading: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: const Text("P R O F I L E"),
              onTap: () {
                Navigator.pop(context);
                context.push('/profile');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              leading: Icon(
                Icons.group,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: Text("U S E R S"),
              onTap: () {
                Navigator.pop(context);
                context.push('/users');
              },
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: ListTile(
              leading: Icon(
                Icons.exit_to_app_outlined,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: Text("L O G O U T"),
              onTap: () => FirebaseAuth.instance.signOut(),
            ),
          ),
        ],
      ),
    );
  }
}
