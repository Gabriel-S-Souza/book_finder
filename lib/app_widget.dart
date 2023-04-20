import 'package:flutter/material.dart';

import 'modules/discover_books/presenter/pages/discover_books_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(colorScheme: const ColorScheme.dark()),
      home: const DiscoverBooksPage(),
    );
  }
}
