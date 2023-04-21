import 'package:flutter/material.dart';

import 'l10n/l10n.dart';

class LocaleService extends ChangeNotifier {
  Locale _locale = L10n.all.first;
  AppLocales _localeEnum = AppLocales.pt;

  Locale get locale => _locale;
  AppLocales get localeEnum => _localeEnum;

  void set(AppLocales localeEnum) {
    _locale = L10n.all[localeEnum.index];
    _localeEnum = localeEnum;
    notifyListeners();
  }
}
