import 'dart:convert';

import 'package:book_finder/core/commom/infra/local_storage.dart';
import 'package:book_finder/core/utils/api_routes.dart';
import 'package:book_finder/core/commom/domain/result.dart';
import 'package:book_finder/core/utils/storage_keys.dart';
import 'package:book_finder/modules/discover_books/domain/entities/book_entity.dart';
import 'package:book_finder/modules/discover_books/infra/datasources/search_books_datasource.dart';
import '../models/book_model.dart';
import '../../../../core/commom/domain/failure.dart';
import '../../../../core/http/http_client.dart';

class BooksDatasourceImp implements BooksDatasource {
  final HttpClient _httpClient;
  final LocalStorage _localStorage;

  BooksDatasourceImp({
    required HttpClient httpClient,
    required LocalStorage localStorage,
  })  : _httpClient = httpClient,
        _localStorage = localStorage;

  @override
  Future<Result<List<BookModel>>> searchBooks(List<String> query) async {
    final queryFormatted = query.join('+');
    try {
      final response = await _httpClient.get('${ApiRoutes.searchBooks}$queryFormatted');
      final books =
          (response.data['items'] as List).map((book) => BookModel.fromJson(book)).toList();
      return Result.success(books);
    } on Failure catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(NotFoundFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<BookModel>>> getFavourites() async {
    try {
      final booksJson = _localStorage.getList(StorageKeys.favouriteBooks) ?? [];
      final books = booksJson.map((book) => BookModel.fromLocalJson(jsonDecode(book))).toList();
      return Result.success(books);
    } on Failure catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(NotFoundFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<BookModel>>> searchBooksLocally(List<String> query) async {
    try {
      final booksJson = _localStorage.getList(StorageKeys.favouriteBooks);
      if (booksJson != null) {
        final books = booksJson.map((book) => BookModel.fromJson(jsonDecode(book))).toList();
        final filteredBooks = books.where((book) {
          final title = book.title.toLowerCase();
          final subtitle = book.subtitle?.toLowerCase() ?? '';
          final description = book.description.toLowerCase();
          final queryFormatted = query.join(' ').toLowerCase();
          final categories = book.categories.join(' ').toLowerCase();
          return title.contains(queryFormatted) ||
              subtitle.contains(queryFormatted) ||
              description.contains(queryFormatted) ||
              categories.contains(queryFormatted);
        }).toList();

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
  Future<Result<bool>> saveFavourite(BookEntity bookEntityToSave) async {
    try {
      final bookToSave = BookModel.fromEntity(bookEntityToSave);
      final booksJson = _localStorage.getList(StorageKeys.favouriteBooks) ?? [];

      final List<Map<String, dynamic>> decodedJsonList = List<Map<String, dynamic>>.from(
          booksJson.map((bookEncoded) => jsonDecode(bookEncoded)).toList());
      final books = decodedJsonList.map((bookMap) => BookModel.fromLocalJson(bookMap)).toList();
      final bookExists = books.any((element) => element.id == bookToSave.id);
      if (!bookExists) {
        books.add(bookToSave);
        final booksStringList = books.map((book) => jsonEncode(book)).toList();
        final result =
            await _localStorage.setList(key: StorageKeys.favouriteBooks, value: booksStringList);
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
  Future<Result<bool>> removeFavourite(String bookId) async {
    try {
      final favourites = _localStorage.getList(StorageKeys.favouriteBooks) ?? [];
      bool removed = false;
      favourites.removeWhere((element) {
        final book = BookModel.fromLocalJson(jsonDecode(element));
        if (book.id == bookId) {
          removed = true;
          return true;
        } else {
          return false;
        }
      });
      await _localStorage.setList(key: StorageKeys.favouriteBooks, value: favourites);
      return Result.success(removed);
    } catch (e) {
      return Result.failure(Failure('Error removing from favourites'));
    }
  }

  @override
  Future<Result<bool>> removeAllFavourites() async {
    try {
      final result = await _localStorage.delete(key: StorageKeys.favouriteBooks);
      return Result.success(result);
    } catch (e) {
      return Result.failure(Failure('Error removing from favourites'));
    }
  }
}
