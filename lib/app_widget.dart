import 'package:book_finder/locale_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/di/service_locator_imp.dart';
import 'modules/discover_books/presenter/pages/discover_books_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ServiceLocatorImp.I.get<LocaleService>(),
      builder: (context, _) {
        return MaterialApp(
          title: 'Book Finder',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.from(colorScheme: const ColorScheme.dark()),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            AppLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: ServiceLocatorImp.I.get<LocaleService>().locale,
          home: const DiscoverBooksPage(),
        );
      },
    );
  }
}
