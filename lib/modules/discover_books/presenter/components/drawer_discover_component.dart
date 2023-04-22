import 'package:book_finder/l10n/l10n.dart';
import 'package:book_finder/modules/discover_books/presenter/widgets/drawer_section_widget.dart';
import 'package:book_finder/modules/discover_books/presenter/widgets/header_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/di/service_locator_imp.dart';
import '../../../../app_config.dart';
import '../../../../core/theme/theme.dart';

class DrawerDiscoverComponent extends StatelessWidget {
  DrawerDiscoverComponent({super.key});

  final _appConfig = ServiceLocatorImp.I.get<AppConfig>();

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
                  groupValue: _appConfig.localeEnum,
                  onChanged: (value) => _appConfig.setLocale(AppLocales.pt),
                  activeColor: Theme.of(context).colorScheme.primary,
                  visualDensity: VisualDensity.compact,
                  dense: true,
                ),
                RadioListTile<AppLocales>(
                  title: Text(t.english),
                  value: AppLocales.en,
                  groupValue: _appConfig.localeEnum,
                  onChanged: (value) => _appConfig.setLocale(AppLocales.en),
                  activeColor: Theme.of(context).colorScheme.primary,
                  visualDensity: VisualDensity.compact,
                  dense: true,
                ),
                RadioListTile<AppLocales>(
                  title: Text(t.spanish),
                  value: AppLocales.es,
                  groupValue: _appConfig.localeEnum,
                  onChanged: (value) => _appConfig.setLocale(AppLocales.es),
                  activeColor: Theme.of(context).colorScheme.primary,
                  visualDensity: VisualDensity.compact,
                  dense: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          DrawerSectionWidget(
            title: t.theme,
            icon: Icons.brightness_4,
            child: Column(
              children: [
                const SizedBox(height: 16),
                RadioListTile<AppTheme>(
                  title: Text(t.light),
                  value: AppTheme.light,
                  groupValue: _appConfig.themeEnum,
                  onChanged: (value) => _appConfig.setTheme(AppTheme.light),
                  activeColor: Theme.of(context).colorScheme.primary,
                  visualDensity: VisualDensity.compact,
                  dense: true,
                ),
                RadioListTile<AppTheme>(
                  title: Text(t.dark),
                  value: AppTheme.dark,
                  groupValue: _appConfig.themeEnum,
                  onChanged: (value) => _appConfig.setTheme(AppTheme.dark),
                  activeColor: Theme.of(context).colorScheme.primary,
                  visualDensity: VisualDensity.compact,
                  dense: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
