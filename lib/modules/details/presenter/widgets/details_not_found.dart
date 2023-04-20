import 'package:flutter/material.dart';

class DetailsNotFoundWidget extends StatelessWidget {
  const DetailsNotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No details found',
        style: TextStyle(
          fontSize: 20,
          color: Theme.of(context).colorScheme.onSurface.withAlpha(200),
        ),
      ),
    );
  }
}
