import 'package:book_finder/modules/discover_books/domain/entities/book_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookCardWidget extends StatelessWidget {
  final BookEntity book;
  final void Function(BookEntity) togglefavorite;
  final void Function(BookEntity) onTap;
  const BookCardWidget({
    super.key,
    required this.book,
    required this.togglefavorite,
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Column(
                  children: [
                    Expanded(
                      flex: 14,
                      child: AspectRatio(
                        aspectRatio: 0.7,
                        child: CachedNetworkImage(
                          imageUrl: book.image,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            size: 56,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Expanded(
                      flex: 5,
                      child: Center(
                        child: Text(
                          book.title,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    _getAuthores.isNotEmpty
                        ? Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                const SizedBox(height: 4),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      _getAuthores,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.color
                                            ?.withAlpha(150),
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
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
                        book.isfavorite ? Icons.favorite : Icons.favorite_border,
                      ),
                      onPressed: () => togglefavorite(book),
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
