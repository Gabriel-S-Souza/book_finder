import 'package:book_finder/modules/discover_books/domain/entities/book_entity.dart';
import 'package:flutter/material.dart';

import '../widgets/book_card_widget.dart';

class GridBooksComponent extends StatefulWidget {
  final List<BookEntity> books;
  final void Function(BookEntity book) togglefavorite;
  final void Function(BookEntity book) onTap;
  const GridBooksComponent({
    super.key,
    required this.books,
    required this.togglefavorite,
    required this.onTap,
  });

  @override
  State<GridBooksComponent> createState() => _GridBooksComponentState();
}

class _GridBooksComponentState extends State<GridBooksComponent> {
  bool get isPortrait => MediaQuery.of(context).orientation == Orientation.portrait;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: isPortrait ? 2 : 3,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      padding: const EdgeInsets.all(16),
      childAspectRatio: 0.75,
      children: List.generate(
        widget.books.length,
        (index) => BookCardWidget(
          book: widget.books[index],
          togglefavorite: widget.togglefavorite,
          onTap: widget.onTap,
        ),
      ),
    );
  }
}
