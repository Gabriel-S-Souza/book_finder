import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoBooksToShowWidget extends StatelessWidget {
  const NoBooksToShowWidget({super.key});

  AppLocalizations t(BuildContext context) => AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        t(context).noBooksToShow,
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).colorScheme.onSurface.withAlpha(200),
        ),
      ),
    );
  }
}
