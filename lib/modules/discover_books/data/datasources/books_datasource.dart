import 'dart:convert';

import 'package:book_finder/core/commom/infra/datasources/local_storage.dart';
import 'package:book_finder/core/utils/api_routes.dart';
import 'package:book_finder/core/commom/domain/result.dart';
import 'package:book_finder/core/utils/storage_keys.dart';
import 'package:book_finder/locale_service.dart';
import 'package:book_finder/modules/discover_books/domain/entities/book_entity.dart';
import 'package:book_finder/modules/discover_books/infra/datasources/books_datasource.dart';
import '../models/book_model.dart';
import '../../../../core/commom/domain/failure.dart';
import '../../../../core/http/http_client.dart';

class BooksDatasourceImp implements BooksDatasource {
  final HttpClient _httpClient;
  final LocalStorage _localStorage;
  final LocaleService _localeService;

  BooksDatasourceImp({
    required HttpClient httpClient,
    required LocalStorage localStorage,
    required LocaleService localeService,
  })  : _httpClient = httpClient,
        _localStorage = localStorage,
        _localeService = localeService;

  @override
  Future<Result<List<BookModel>>> searchBooks(
    String query, [
    int pageNumber = 1,
  ]) async {
    final queryFormatted = _getListOfWords(query).join('+');
    // TODO: Implement pagination
    final int startIndex = _getStartIndex(pageNumber);
    // log('pageNumber: $pageNumber');
    // log('startNumber: $startIndex');

    final String locale = _localeService.locale.languageCode;

    try {
      final response = await _httpClient.get(
          '${ApiRoutes.searchBooks}$queryFormatted&maxResults=40&startIndex=$startIndex&langRestrict=$locale');
      final books =
          (response.data['items'] as List).map((book) => BookModel.fromJson(book)).toList();

      final favoriteResponse = await getfavorites();
      final favoriteBooks = favoriteResponse.isSuccess ? favoriteResponse.data : [];

      final booksResult = _markfavoriteBooks(books, favoriteBooks);

      return Result.success(booksResult);
    } on Failure catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(NotFoundFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<BookModel>>> getfavorites() async {
    try {
      final booksJson = _localStorage.getList(StorageKeys.favoriteBooks) ?? [];
      final books = booksJson.map((book) => BookModel.fromLocalJson(jsonDecode(book))).toList();
      return Result.success(books);
    } on Failure catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(NotFoundFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<BookModel>>> searchBooksLocally(String query) async {
    try {
      final booksJson = _localStorage.getList(StorageKeys.favoriteBooks);
      if (booksJson != null) {
        final books = booksJson.map((book) => BookModel.fromLocalJson(jsonDecode(book))).toList();

        final searchQuery = query.toLowerCase();

        final filteredBooks = books
            .where((book) => book.title.toLowerCase().contains(searchQuery) ||
                    book.description != null
                ? book.description!.toLowerCase().contains(searchQuery)
                : false ||
                    book.authors.any((author) => author.toLowerCase().contains(searchQuery)) ||
                    book.categories.any((category) => category.toLowerCase().contains(searchQuery)))
            .toList();

        return Result.success(filteredBooks);
      } else {
        return const Result.success([]);
      }
    } on Failure catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(NotFoundFailure(e.toString()));
    }
  }

  @override
  Future<Result<bool>> savefavorite(BookEntity bookEntityToSave) async {
    try {
      final bookToSave = BookModel.fromEntity(bookEntityToSave);
      final booksJson = _localStorage.getList(StorageKeys.favoriteBooks) ?? [];

      final List<Map<String, dynamic>> decodedJsonList = List<Map<String, dynamic>>.from(
          booksJson.map((bookEncoded) => jsonDecode(bookEncoded)).toList());
      final books = decodedJsonList.map((bookMap) => BookModel.fromLocalJson(bookMap)).toList();
      final bookExists = books.any((element) => element.id == bookToSave.id);
      if (!bookExists) {
        books.add(bookToSave);
        final booksStringList = books.map((book) => jsonEncode(book)).toList();
        final result =
            await _localStorage.setList(key: StorageKeys.favoriteBooks, value: booksStringList);
        return Result.success(result);
      } else {
        return const Result.success(true);
      }
    } on Failure catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(Failure(e.toString()));
    }
  }

  @override
  Future<Result<bool>> removefavorite(String bookId) async {
    try {
      final favorites = _localStorage.getList(StorageKeys.favoriteBooks) ?? [];
      bool removed = false;
      favorites.removeWhere((element) {
        final book = BookModel.fromLocalJson(jsonDecode(element));
        if (book.id == bookId) {
          removed = true;
          return true;
        } else {
          return false;
        }
      });
      await _localStorage.setList(key: StorageKeys.favoriteBooks, value: favorites);
      return Result.success(removed);
    } catch (e) {
      return Result.failure(Failure('Error removing from favorites'));
    }
  }

  @override
  Future<Result<bool>> removeAllfavorites() async {
    try {
      final result = await _localStorage.delete(key: StorageKeys.favoriteBooks);
      return Result.success(result);
    } catch (e) {
      return Result.failure(Failure('Error removing from favorites'));
    }
  }

  List<String> _getListOfWords(String query) {
    return query.trim().split(' ');
  }

  List<BookModel> _markfavoriteBooks(List<BookModel> books, List favoriteBooks) {
    final booksResult = books.map((book) {
      final bookExists = favoriteBooks.any((element) => element.id == book.id);
      if (bookExists) {
        return book..isfavorite = true;
      } else {
        return book;
      }
    }).toList();
    return booksResult;
  }

  int _getStartIndex(int pageNumber) {
    return pageNumber == 1 ? 0 : (pageNumber - 1) * 40;
  }
}
