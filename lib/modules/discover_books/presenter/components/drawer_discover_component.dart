import 'package:book_finder/l10n/l10n.dart';
import 'package:book_finder/modules/discover_books/presenter/widgets/drawer_section_widget.dart';
import 'package:book_finder/modules/discover_books/presenter/widgets/header_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DrawerDiscoverComponent extends StatelessWidget {
  final void Function(AppLocales locale) onLanguageChanged;
  final AppLocales currentLocale;
  const DrawerDiscoverComponent({
    super.key,
    required this.onLanguageChanged,
    required this.currentLocale,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeaderWidget(),
          const SizedBox(height: 8),
          DrawerSectionWidget(
              title: t.language,
              icon: Icons.language,
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  RadioListTile<AppLocales>(
                    title: Text(t.portuguese),
                    value: AppLocales.pt,
                    groupValue: currentLocale,
                    onChanged: (value) => onLanguageChanged(AppLocales.pt),
                    activeColor: Theme.of(context).colorScheme.primary,
                    visualDensity: VisualDensity.compact,
                    dense: true,
                  ),
                  RadioListTile<AppLocales>(
                    title: Text(t.english),
                    value: AppLocales.en,
                    groupValue: currentLocale,
                    onChanged: (value) => onLanguageChanged(AppLocales.en),
                    activeColor: Theme.of(context).colorScheme.primary,
                    visualDensity: VisualDensity.compact,
                    dense: true,
                  ),
                  RadioListTile<AppLocales>(
                    title: Text(t.spanish),
                    value: AppLocales.es,
                    groupValue: currentLocale,
                    onChanged: (value) => onLanguageChanged(AppLocales.es),
                    activeColor: Theme.of(context).colorScheme.primary,
                    visualDensity: VisualDensity.compact,
                    dense: true,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
