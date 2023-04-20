import 'package:book_finder/core/commom/domain/result.dart';
import 'package:book_finder/modules/discover_books/domain/entities/book_entity.dart';
import 'package:book_finder/modules/discover_books/domain/usecases/search_books_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/save_favorite_usecase.dart';
import '../../domain/usecases/get_favorites_use_case.dart';
import '../../domain/usecases/remove_favorite_usecase.dart';

class DiscoverBooksController extends ChangeNotifier {
  final SearchBooksUseCase _searchBooksUseCase;
  final GetfavoritesUseCase _getfavoritesUseCase;
  final SaveFavoriteBookUseCase _saveFavoriteBookUseCase;
  final RemovefavoritesUseCase _removeFromfavoritesUseCase;

  DiscoverBooksController({
    required SearchBooksUseCase searchBooksUseCase,
    required GetfavoritesUseCase getfavoritesUseCase,
    required SaveFavoriteBookUseCase saveFavoriteBookUseCase,
    required RemovefavoritesUseCase removeFromfavoritesUseCase,
  })  : _searchBooksUseCase = searchBooksUseCase,
        _getfavoritesUseCase = getfavoritesUseCase,
        _saveFavoriteBookUseCase = saveFavoriteBookUseCase,
        _removeFromfavoritesUseCase = removeFromfavoritesUseCase;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  final List<BookEntity> _books = [];

  final List<BookEntity> _favoriteBooks = [];

  List<BookEntity> get books => _books;

  List<BookEntity> get booksToShow => _tabIsfavorites ? _favoriteBooks : _books;

  bool _tabIsfavorites = false;

  List<BookEntity> get favoriteBooks => _favoriteBooks;

  bool get tabIsfavorites => _tabIsfavorites;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<Result<bool>> searchBooks(String query) async {
    setLoading(true);
    final response = await _searchBooksUseCase(query);
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
    _tabIsfavorites = false;

    setLoading(false);
    return result;
  }

  Future<Result<bool>> getfavorites() async {
    setLoading(true);
    final response = await _getfavoritesUseCase();
    late final Result<bool> result;

    response.when(
      success: (books) {
        _favoriteBooks.clear();
        _favoriteBooks.addAll(books);
        result = const Result.success(true);
      },
      failure: (error) {
        result = Result.failure(error);
      },
    );

    _tabIsfavorites = true;

    setLoading(false);
    return result;
  }

  void setTabIsfavorites(bool value) {
    _tabIsfavorites = value;
    if (_tabIsfavorites) {
      getfavorites();
    }
    notifyListeners();
  }

  Future<void> togglefavoriteBook(BookEntity book) async {
    book.isfavorite = !book.isfavorite;
    if (book.isfavorite) {
      _favoriteBooks.add(book);
      await _saveFavoriteBookUseCase(book);
    } else {
      final index = _favoriteBooks.indexWhere((element) => element.id == book.id);
      _favoriteBooks.removeAt(index);
      try {
        _books.firstWhere((element) => element.id == book.id).isfavorite = false;
      } on StateError catch (e) {
        debugPrint(e.toString());
      }
      await _removeFromfavoritesUseCase(book);
    }
    notifyListeners();
  }
}
