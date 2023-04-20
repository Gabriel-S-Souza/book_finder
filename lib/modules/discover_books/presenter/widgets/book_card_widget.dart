import 'package:book_finder/modules/discover_books/domain/entities/book_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookCardWidget extends StatelessWidget {
  final BookEntity book;
  final void Function(BookEntity) toggleFavourite;
  final void Function(BookEntity) onTap;
  const BookCardWidget({
    super.key,
    required this.book,
    required this.toggleFavourite,
    required this.onTap,
  });

  String get _getAuthores => book.authors.join(', ');

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap: () => onTap(book),
        child: Card(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: book.smallImage ?? book.image,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(book.title),
                    Text(_getAuthores),
                  ],
                ),
              ),
              Positioned(
                top: -2,
                right: -2,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor.withOpacity(0.02),
                        Theme.of(context).primaryColor.withOpacity(0.6),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: IconButton(
                      icon: Icon(
                        book.isFavourite ? Icons.favorite : Icons.favorite_border,
                      ),
                      onPressed: () => toggleFavourite(book),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
