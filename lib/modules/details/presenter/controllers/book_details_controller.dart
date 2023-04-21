import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/commom/domain/result.dart';
import '../../../../core/utils/currency_code_formatter.dart';
import '../../domain/entities/book_details_entity.dart';
import '../../domain/usecases/get_details_use_case.dart';
import '../../domain/usecases/remove_favorite_from_details_usecase.dart';
import '../../domain/usecases/save_favorite_usecase.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookDetailsController extends ChangeNotifier {
  final GetDetailsUseCase _getDetailsUseCase;
  final SaveFavoriteFromDetailsUseCase _saveFavoriteBookUseCase;
  final RemovefavoriteFromDetailsUseCase _removeFromfavoritesUseCase;

  BookDetailsController({
    required GetDetailsUseCase getDetailsUseCase,
    required SaveFavoriteFromDetailsUseCase saveFavoriteBookUseCase,
    required RemovefavoriteFromDetailsUseCase removeFromfavoritesUseCase,
  })  : _getDetailsUseCase = getDetailsUseCase,
        _saveFavoriteBookUseCase = saveFavoriteBookUseCase,
        _removeFromfavoritesUseCase = removeFromfavoritesUseCase;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool requiresRefreshOnBack = false;

  String get getAuthores => bookDetails?.authors.join(', ') ?? '';

  BookDetailsEntity? get bookDetails => _bookDetails;

  BookDetailsEntity? _bookDetails;

  bool get forSale => isLoading == false && bookDetails?.forSale == true;

  String getPrice(AppLocalizations t) {
    if (isLoading == false && bookDetails?.forSale == true) {
      if (bookDetails?.price == 0) {
        return t.free;
      }
      return '${currencyCodeFormatter(bookDetails!.currencyCode!)} ${bookDetails?.price?.toStringAsFixed(2)} ${t.buyBook}';
    }
    return t.priceNoAvailable;
  }

  void setBookDetails(BookDetailsEntity book) {
    _bookDetails = book;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<Result<bool>> getDetails(String bookId) async {
    setLoading(true);
    final response = await _getDetailsUseCase(bookId);
    late final Result<bool> result;

    response.when(
      success: (book) {
        _bookDetails = book;
        result = const Result.success(true);
      },
      failure: (error) {
        result = Result.failure(error);
      },
    );

    setLoading(false);
    return result;
  }

  Future<void> togglefavoriteBook(BookDetailsEntity book) async {
    book.isfavorite = !book.isfavorite;
    if (book.isfavorite) {
      await _saveFavoriteBookUseCase(book);
    } else {
      await _removeFromfavoritesUseCase(book);
    }
    requiresRefreshOnBack = true;
    notifyListeners();
  }

  Future<void> launchInfoLink() async {
    if (bookDetails?.previewLink != null) {
      await _launchUrl(bookDetails!.infoLink);
    }
  }

  Future<void> launchBuyLink() async {
    if (bookDetails?.buyLink != null) {
      await _launchUrl(bookDetails!.buyLink!);
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }
}
