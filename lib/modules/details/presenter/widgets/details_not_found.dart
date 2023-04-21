import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailsNotFoundWidget extends StatelessWidget {
  const DetailsNotFoundWidget({super.key});

  AppLocalizations t(BuildContext context) => AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        t(context).detailsNotFound,
        style: TextStyle(
          fontSize: 20,
          color: Theme.of(context).colorScheme.onSurface.withAlpha(200),
        ),
      ),
    );
  }
}
