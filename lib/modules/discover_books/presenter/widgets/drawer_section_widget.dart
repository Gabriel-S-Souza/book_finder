import 'package:flutter/material.dart';

class DrawerSectionWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  const DrawerSectionWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          dense: true,
          visualDensity: VisualDensity.compact,
          horizontalTitleGap: 16,
          leading: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.onSurface.withAlpha(200),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 16),
          child: child,
        ),
      ],
    );
  }
}
