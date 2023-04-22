import 'package:book_finder/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/di/service_locator_imp.dart';
import 'modules/discover_books/presenter/pages/discover_books_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appConfig = ServiceLocatorImp.I.get<AppConfig>();
    return AnimatedBuilder(
      animation: appConfig,
      builder: (context, _) {
        return MaterialApp(
          title: 'Book Finder',
          debugShowCheckedModeBanner: false,
          theme: appConfig.theme,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            AppLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: appConfig.locale,
          home: const DiscoverBooksPage(),
        );
      },
    );
  }
}
