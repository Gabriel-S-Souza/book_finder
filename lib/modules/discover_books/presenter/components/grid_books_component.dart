import 'package:book_finder/modules/discover_books/domain/entities/book_entity.dart';
import 'package:flutter/material.dart';

import '../widgets/book_card_widget.dart';

class GridBooksComponent extends StatelessWidget {
  final List<BookEntity> books;
  final void Function(BookEntity book) toggleFavourite;
  const GridBooksComponent({
    super.key,
    required this.books,
    required this.toggleFavourite,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      padding: const EdgeInsets.all(16),
      childAspectRatio: 0.75,
      children: List.generate(
        books.length,
        (index) => BookCardWidget(
          book: books[index],
          toggleFavourite: toggleFavourite,
        ),
      ),
    );
  }
}
