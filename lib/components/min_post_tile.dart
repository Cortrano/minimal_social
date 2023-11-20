import 'package:flutter/material.dart';

class MINPostTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const MINPostTile({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25.0,
        bottom: 10.0,
        right: 25.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ListTile(
          title: Text(title),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
    ;
  }
}
