import 'package:book_finder/core/commom/domain/result.dart';
import 'package:book_finder/modules/discover_books/domain/entities/book_entity.dart';
import 'package:book_finder/modules/discover_books/domain/usecases/search_books_use_case.dart';
import 'package:flutter/foundation.dart';

import '../../domain/usecases/favourite_book_usecase.dart';
import '../../domain/usecases/get_favourites_use_case.dart';
import '../../domain/usecases/remove_from_favourites_usecase.dart';

class DiscoverBooksController extends ChangeNotifier {
  final SearchBooksUseCase _searchBooksUseCase;
  final GetFavouritesUseCase _getFavouritesUseCase;
  final SaveFavoriteBookUseCase _saveFavoriteBookUseCase;
  final RemoveFavouritesUseCase _removeFromFavouritesUseCase;

  DiscoverBooksController({
    required SearchBooksUseCase searchBooksUseCase,
    required GetFavouritesUseCase getFavouritesUseCase,
    required SaveFavoriteBookUseCase saveFavoriteBookUseCase,
    required RemoveFavouritesUseCase removeFromFavouritesUseCase,
  })  : _searchBooksUseCase = searchBooksUseCase,
        _getFavouritesUseCase = getFavouritesUseCase,
        _saveFavoriteBookUseCase = saveFavoriteBookUseCase,
        _removeFromFavouritesUseCase = removeFromFavouritesUseCase;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  final List<BookEntity> _books = [];

  final List<BookEntity> _favouriteBooks = [];

  List<BookEntity> get books => _books;

  bool _tabIsFavourites = false;

  List<BookEntity> get favouriteBiiks => _favouriteBooks;

  bool get tabIsFavourites => _tabIsFavourites;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<Result<bool>> searchBooks(String query) async {
    setLoading(true);
    final response = await _searchBooksUseCase(_getListOfWords(query));
    late final Result<bool> result;

    response.when(
      success: (books) {
        _books.clear();
        _books.addAll(books);
        result = const Result.success(true);
      },
      failure: (error) {
        result = Result.failure(error);
      },
    );

    _tabIsFavourites = false;

    setLoading(false);
    return result;
  }

  Future<Result<bool>> getFavourites() async {
    setLoading(true);
    final response = await _getFavouritesUseCase();
    late final Result<bool> result;

    response.when(
      success: (books) {
        _favouriteBooks.clear();
        _favouriteBooks.addAll(books);
        result = const Result.success(true);
      },
      failure: (error) {
        result = Result.failure(error);
      },
    );

    _tabIsFavourites = false;

    setLoading(false);
    return result;
  }

  List<String> _getListOfWords(String query) {
    return query.trim().split(' ');
  }

  void setTabIsFavourites(bool value) {
    _tabIsFavourites = value;
    notifyListeners();
  }

  Future<void> toggleFavouriteBook(BookEntity book) async {
    book.isFavourite = !book.isFavourite;
    final index = _books.indexWhere((element) => element.id == book.id);
    _books[index] = book;
    print(book.isFavourite);
    if (book.isFavourite) {
      await _saveFavoriteBookUseCase(book);
    } else {
      await _removeFromFavouritesUseCase(book);
    }
    notifyListeners();
  }
}
