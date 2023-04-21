import 'package:book_finder/core/di/service_locator_imp.dart';
import 'package:book_finder/modules/details/data/models/book_details_model.dart';
import 'package:book_finder/modules/details/presenter/widgets/elevated_button_widget.dart';
import 'package:book_finder/modules/discover_books/data/models/book_model.dart';
import 'package:book_finder/modules/discover_books/domain/entities/book_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/commom/presenter/widgets/loading_widget.dart';
import '../components/book_informations_component.dart';
import '../components/image_viewer_component.dart';
import '../controllers/book_details_controller.dart';
import '../widgets/details_not_found.dart';

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

  AppLocalizations get t => AppLocalizations.of(context)!;

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            if (_controller.isLoading) {
              return const LoadingWidget();
            } else if (_controller.bookDetails == null) {
              return const DetailsNotFoundWidget();
            }
            return SingleChildScrollView(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16, 0, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageViewerComponent(
                          imageUrl: _controller.bookDetails!.image,
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: BookInformationsComponent(
                            controller: _controller,
                            description: widget.bookEntity.description ??
                                _controller.bookDetails!.description ??
                                t.noDescription,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 8,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(_controller.requiresRefreshOnBack),
                      icon: const Icon(Icons.arrow_back),
                      iconSize: 28,
                      color: Theme.of(context).colorScheme.onPrimary.withAlpha(180),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        persistentFooterButtons: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              if (_controller.forSale) {
                return ElevatedButtonWidget(
                  onPressed: !_controller.isLoading
                      ? () async {
                          _controller.launchBuyLink();
                        }
                      : null,
                  text: _controller.getPrice(t),
                );
              } else {
                return ElevatedButtonWidget(
                  onPressed: !_controller.isLoading
                      ? () async {
                          _controller.launchInfoLink();
                        }
                      : null,
                  text: t.openInGoogleBooks,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
