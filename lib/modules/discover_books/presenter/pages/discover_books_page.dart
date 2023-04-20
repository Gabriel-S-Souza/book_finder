import 'package:book_finder/core/di/service_locator_imp.dart';
import 'package:book_finder/modules/discover_books/presenter/components/grid_books_component.dart';
import 'package:book_finder/modules/discover_books/presenter/controllers/discover_books_controller.dart';
import 'package:flutter/material.dart';

import '../components/search_bar_component.dart';

class DiscoverBooksPage extends StatelessWidget {
  DiscoverBooksPage({super.key});

  final _controller = ServiceLocatorImp.I.get<DiscoverBooksController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SearchBarComponent(
          onSearch: _controller.searchBooks,
        ),
        body: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            if (_controller.books.isEmpty) {
              return const Center(
                child: Text('No books found'),
              );
            }

            if (_controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return GridBooksComponent(
              books: _controller.books,
              toggleFavourite: _controller.toggleFavouriteBook,
            );
          },
        ),
      ),
    );
  }
}
