import 'package:flutter/material.dart';

import '../../../../core/commom/domain/result.dart';
import '../../domain/entities/book_details_entity.dart';
import '../../domain/usecases/get_details_use_case.dart';
import '../../domain/usecases/remove_favourite_from_details_usecase.dart';
import '../../domain/usecases/save_favourite_usecase.dart';

class BookDetailsController extends ChangeNotifier {
  final GetDetailsUseCase _getDetailsUseCase;
  final SaveFavoriteFromDetailsUseCase _saveFavoriteBookUseCase;
  final RemoveFavouriteFromDetailsUseCase _removeFromFavouritesUseCase;

  BookDetailsController({
    required GetDetailsUseCase getDetailsUseCase,
    required SaveFavoriteFromDetailsUseCase saveFavoriteBookUseCase,
    required RemoveFavouriteFromDetailsUseCase removeFromFavouritesUseCase,
  })  : _getDetailsUseCase = getDetailsUseCase,
        _saveFavoriteBookUseCase = saveFavoriteBookUseCase,
        _removeFromFavouritesUseCase = removeFromFavouritesUseCase;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool requiresRefreshOnBack = false;

  String get getAuthores => bookDetails?.authors.join(', ') ?? '';

  BookDetailsEntity? get bookDetails => _bookDetails;

  BookDetailsEntity? _bookDetails;

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

  Future<void> toggleFavouriteBook(BookDetailsEntity book) async {
    book.isFavourite = !book.isFavourite;
    if (book.isFavourite) {
      await _saveFavoriteBookUseCase(book);
    } else {
      await _removeFromFavouritesUseCase(book);
    }
    requiresRefreshOnBack = true;
    notifyListeners();
  }
}
