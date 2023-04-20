import 'package:book_finder/core/di/service_locator_imp.dart';
import 'package:book_finder/core/utils/currency_code_formatter.dart';
import 'package:book_finder/modules/details/data/models/book_details_model.dart';
import 'package:book_finder/modules/discover_books/data/models/book_model.dart';
import 'package:book_finder/modules/discover_books/domain/entities/book_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../controllers/book_details_controller.dart';

class BookDetailsPage extends StatefulWidget {
  final BookEntity bookEntity;
  const BookDetailsPage({
    super.key,
    required this.bookEntity,
  });

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  final _controller = ServiceLocatorImp.I.get<BookDetailsController>();

  @override
  void initState() {
    super.initState();
    _controller.getDetails(widget.bookEntity.id).then((value) {
      if (!value.isSuccess) {
        final BookModel bookModel = BookModel.fromEntity(widget.bookEntity);
        _controller.setBookDetails(BookDetailsModel.fromLocalJson(bookModel.toJson()));
      }
    });
  }

  bool get isPortrait => MediaQuery.of(context).orientation == Orientation.portrait;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              if (_controller.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (_controller.bookDetails == null) {
                return const Center(
                  child: Text(
                    'No details found',
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }

              return SingleChildScrollView(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 50),
                          Align(
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              height: isPortrait
                                  ? MediaQuery.of(context).size.height * 0.3
                                  : MediaQuery.of(context).size.height * 0.5,
                              child: AspectRatio(
                                aspectRatio: 0.7,
                                child: CachedNetworkImage(
                                  imageUrl: _controller.bookDetails!.image,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _controller.bookDetails!.title,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              _controller.getAuthores.isNotEmpty
                                  ? Column(
                                      children: [
                                        const SizedBox(height: 16),
                                        Text(
                                          _controller.getAuthores,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                              const SizedBox(height: 16),
                              Text(
                                widget.bookEntity.description ??
                                    _controller.bookDetails?.description ??
                                    'No description',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 2,
                      left: 4,
                      child: IconButton(
                        onPressed: () =>
                            Navigator.of(context).pop(_controller.requiresRefreshOnBack),
                        icon: const Icon(Icons.arrow_back),
                        // color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        persistentFooterButtons: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              if (_controller.forSale) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 46,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        _controller.launchBuyLink();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _controller.price!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 46,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _controller.launchInfoLink,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'More info',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (_controller.forSale)
                            const Icon(
                              Icons.preview,
                              size: 20,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
