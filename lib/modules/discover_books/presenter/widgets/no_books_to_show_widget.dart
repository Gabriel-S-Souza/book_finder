import 'package:flutter/material.dart';

class NoBooksToShowWidget extends StatelessWidget {
  const NoBooksToShowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No books to show',
        style: TextStyle(
          fontSize: 20,
          color: Theme.of(context).colorScheme.onSurface.withAlpha(200),
        ),
      ),
    );
  }
}
