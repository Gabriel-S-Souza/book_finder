import 'package:book_finder/core/commom/infra/datasources/local_storage.dart';
import 'package:flutter/material.dart';

import 'core/theme/theme.dart';
import 'l10n/l10n.dart';

class AppConfig extends ChangeNotifier {
  final LocalStorage _localStorage;
  final String _themeKey = 'theme';

  AppConfig({
    required LocalStorage localStorage,
  }) : _localStorage = localStorage {
    _init();
  }

  Locale locale = L10n.all.first;
  AppLocales localeEnum = AppLocales.pt;

  void setLocale(AppLocales newLocale) {
    locale = L10n.all[newLocale.index];
    localeEnum = newLocale;
    notifyListeners();
  }

  ThemeData theme = lightTheme;
  AppTheme themeEnum = AppTheme.light;

  void setTheme(AppTheme newTheme) {
    theme = newTheme == AppTheme.light ? lightTheme : darkTheme;
    themeEnum = newTheme;
    _localStorage.set(key: _themeKey, value: newTheme.toString());
    notifyListeners();
  }

  void _init() {
    final themeString = _localStorage.get(_themeKey);
    if (themeString != null) {
      final themeSaved = AppTheme.values.firstWhere(
        (e) => e.toString() == themeString,
        orElse: () => AppTheme.light,
      );
      themeEnum = themeSaved;
      theme = themeSaved == AppTheme.light ? lightTheme : darkTheme;
    }
  }
}
